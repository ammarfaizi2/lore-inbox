Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUIIR2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUIIR2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUIIR0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:26:02 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:13228 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266459AbUIIRYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:24:18 -0400
Date: Thu, 9 Sep 2004 13:23:01 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Makan Pourzandi <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909172301.GA28466@escher.cs.wm.edu>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909092457.L1973@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >      - support to avoid vulnerability for rewrite of shared
> >      libraries
> 
> Could you elaborate on this one?

When a file is being executed, deny_write_access(file) is called to
prevent writing until execution completes.  Because deny_write_access
is not exported from fs/namei.c, we emulate this behavior for shared
libraries.

> > Future works
> > =============
> > 
> >      - improving the caching and revocation: it is currently tested
> >        and will be sent out soon after stability testing
> 
> Should be helpful enough to cache result until thing's opened for
> writing, or is that what you're doing now?

Exactly.  When the file is opened for writing (which as much as possible
requires the file to not be executed), we uncache the signature
validation.

(The new patch hashes revocations (they were on a linked list), and
steals the seqlock-based structure Rik van Riel had suggested for
the selinux avc cache for use in the signature revocation cache.  There
is no change in functionality, only (hopefully) performance improvements.)

-serge

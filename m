Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUIIRwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUIIRwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUIIRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:50:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:9644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266427AbUIIRnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:43:03 -0400
Date: Thu, 9 Sep 2004 10:42:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Makan Pourzandi <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909104256.T1924@build.pdx.osdl.net>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <20040909172301.GA28466@escher.cs.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909172301.GA28466@escher.cs.wm.edu>; from serue@us.ibm.com on Thu, Sep 09, 2004 at 01:23:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> > >      - support to avoid vulnerability for rewrite of shared
> > >      libraries
> > 
> > Could you elaborate on this one?
> 
> When a file is being executed, deny_write_access(file) is called to
> prevent writing until execution completes.  Because deny_write_access
> is not exported from fs/namei.c, we emulate this behavior for shared
> libraries.

Hmm, ok, so you're relying on the loader to do PROT_EXEC mmaps for
shared libraries?  Probably not required at least on x86.  Also, does
this work when executing loader directly (/lib/ld.so /bin/ps), and with
dlopen?

> > > Future works
> > > =============
> > > 
> > >      - improving the caching and revocation: it is currently tested
> > >        and will be sent out soon after stability testing
> > 
> > Should be helpful enough to cache result until thing's opened for
> > writing, or is that what you're doing now?
> 
> Exactly.  When the file is opened for writing (which as much as possible
> requires the file to not be executed), we uncache the signature
> validation.
> 
> (The new patch hashes revocations (they were on a linked list), and
> steals the seqlock-based structure Rik van Riel had suggested for
> the selinux avc cache for use in the signature revocation cache.  There
> is no change in functionality, only (hopefully) performance improvements.)

Ok, I see.  Makes sense.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

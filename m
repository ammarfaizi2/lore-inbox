Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUIISs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUIISs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUIISpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:45:41 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:4271 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266674AbUIISnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:43:50 -0400
Date: Thu, 9 Sep 2004 14:43:27 -0400
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: Chris Wright <chrisw@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Makan Pourzandi <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909184327.GA28807@escher.cs.wm.edu>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <20040909172301.GA28466@escher.cs.wm.edu> <20040909104256.T1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909104256.T1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When a file is being executed, deny_write_access(file) is called to
> > prevent writing until execution completes.  Because deny_write_access
> > is not exported from fs/namei.c, we emulate this behavior for shared
> > libraries.
> 
> Hmm, ok, so you're relying on the loader to do PROT_EXEC mmaps for
> shared libraries?  Probably not required at least on x86.

Correct.

We don't pretend to stop someone from mmap'ing and executing bad code, we
only want to help someone who wants to use a legitimate library to know that
the right library is being used.

> Also, does
> this work when executing loader directly (/lib/ld.so /bin/ps), and with
> dlopen?

Yup, both of these (at least on i386) use mmap with PROT_EXEC, and go
through digsig's dsi_file_mmap check.  (I've made a note to check the
/lib/ld.so /bin/ps case on a powerpc and, if I can find one, z)

-serge

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTDGDUh (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTDGDUg (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:20:36 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:44416 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263219AbTDGDUf (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 23:20:35 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Mon, 7 Apr 2003 13:32:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.61751.120794.728107@notabene.cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: Can't unmount fs after using NFS
In-Reply-To: message from Felipe Alfaro Solana on  March 30
References: <1049036587.600.9.camel@teapot>
X-Mailer: VM 7.13 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  March 30, felipe_alfaro@linuxmail.org wrote:
> Hi,
> 
> Since I started testing 2.5 on my NFS server, I'm having problems
> unmounting filesystems that were exported by NFS (of course, before
> trying to unmount, I stopped NFS):

Thankyou for the bug report.  After spending far too long looking in
the wrong place, I looked in the right place and found it.
This patch should fix it.

NeilBrown


diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2003-04-07 10:42:48.000000000 +1000
+++ ./fs/nfsd/export.c	2003-04-07 13:25:55.000000000 +1000
@@ -838,7 +836,7 @@ exp_rootfh(svc_client *clp, char *path, 
 		err = 0;
 	memcpy(f, &fh.fh_handle, sizeof(struct knfsd_fh));
 	fh_put(&fh);
-
+	exp_put(exp);
 out:
 	path_release(&nd);
 	return err;

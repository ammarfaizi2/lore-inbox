Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUE2DYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUE2DYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 23:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUE2DYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 23:24:49 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:29130 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262873AbUE2DYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 23:24:48 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org
Date: Sat, 29 May 2004 13:24:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16568.621.199870.484447@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfsd oops 2.6.7-rc1
In-Reply-To: message from William Lee Irwin III on Friday May 28
References: <20040529023550.GB2370@holomorphy.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 28, wli@holomorphy.com wrote:
> While idle, the following oops happened. On virgin 2.6.7-rc1.
> 

Ok, I think I've found it.  There is a missing dget.  See below/.
NeilBrown

=====================================================
Another missing dget

The recentish change to fh_compose not consuming a reference
to the passed dentries missed this needed dget.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

 ----------- Diffstat output ------------
 ./fs/nfsd/vfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2004-05-29 13:21:19.000000000 +1000
+++ ./fs/nfsd/vfs.c	2004-05-29 13:21:36.000000000 +1000
@@ -899,7 +899,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 			goto out;
 	} else {
 		/* called from nfsd_proc_create */
-		dchild = resfhp->fh_dentry;
+		dchild = dget(resfhp->fh_dentry);
 		if (!fhp->fh_locked) {
 			/* not actually possible */
 			printk(KERN_ERR

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTKJDFs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 22:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTKJDFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 22:05:48 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:37032 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262827AbTKJDFr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 22:05:47 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 10 Nov 2003 14:05:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16303.131.838605.661991@notabene.cse.unsw.edu.au>
Cc: Burton Windle <bwindle@fint.org>, Linux-kernel@vger.kernel.org
Subject: Re: slab corruption in test9 (NFS related?)
In-Reply-To: message from Andrew Morton on Sunday November 9
References: <Pine.LNX.4.58.0311091815460.872@morpheus>
	<20031109190444.5d8d6645.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 9, akpm@osdl.org wrote:
> Burton Windle <bwindle@fint.org> wrote:
> > Slab corruption: start=c9df6bcc, expend=c9df6c8b, problemat=c9df6bcc
> > Last user: [<c017f87e>](d_callback+0x1e/0x40)
> > Data: 6A**********************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7E F8 17 C0 A5 C2 0F 17 00 00 00 00 08 00 00 00 3C 4B 24 1D 00 00 00 00 0A 00 00 00 slab error in check_poison_obj(): cache
> > 
> 
> Someone did a dput() of a freed dentry.  This is quite possibly an
> nfsd bug.

Ahhh.  That would be:


===============================================
An extra dput was introduced in nfsd_rename 20 months ago....

time to remove it.

 ----------- Diffstat output ------------
 ./fs/nfsd/vfs.c |    1 -
 1 files changed, 1 deletion(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2003-11-05 11:25:45.000000000 +1100
+++ ./fs/nfsd/vfs.c	2003-11-05 11:25:59.000000000 +1100
@@ -1368,7 +1368,6 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 		nfsd_sync_dir(tdentry);
 		nfsd_sync_dir(fdentry);
 	}
-	dput(ndentry);
 
  out_dput_new:
 	dput(ndentry);

==============================================

NeilBrown

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbREXKdD>; Thu, 24 May 2001 06:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbREXKcy>; Thu, 24 May 2001 06:32:54 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:64005 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261217AbREXKcl>; Thu, 24 May 2001 06:32:41 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Praveen Srinivasan <praveens@stanford.edu>
Date: Thu, 24 May 2001 20:32:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15116.58164.554112.410225@notabene.cse.unsw.edu.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, mingo@redhat.com
Subject: Re: [PATCH] md.c - null ptr fixes for 2.4.4
In-Reply-To: message from Praveen Srinivasan on Thursday May 24
In-Reply-To: <200105240732.f4O7WLH23332@smtp2.Stanford.EDU>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 24, praveens@stanford.edu wrote:
> Hi,
> This patch fixes some unchecked ptr bugs in the multiple devices driver 
> (RAID) code (md.c).
> 
> Praveen Srinivasan and Frederick Akalin

Thankyou.
However I suspect that a much simpler patch would be:

--- ../linux/./drivers/md/md.c	Fri Apr  6 10:42:55 2001
+++ ./drivers/md/md.c	Mon May  7 22:08:02 2001
@@ -3756,6 +3756,10 @@
 			continue;
 		}
 		mddev = alloc_mddev(MKDEV(MD_MAJOR,minor));
+		if (mddev == NULL) {
+			printk("md: kmalloc failed - cannot start array %d\n", minor);
+			continue;
+		}
 		if (md_setup_args.pers[minor]) {
 			/* non-persistent */
 			mdu_array_info_t ainfo;


WARNING - patch created by hand, not tested.

If this is an issue. i.e. if alloc_mddev fails this early in the boot 
sequence, then I think you have a very sick computer...

NeilBrown

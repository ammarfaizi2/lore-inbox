Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUF1UBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUF1UBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUF1UBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:01:43 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:60681 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265154AbUF1UBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:01:36 -0400
Date: Mon, 28 Jun 2004 22:01:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: freaky@bananateam.nl
Cc: Andries Brouwer <aeb@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: USB Memory Stick issues (After using it in Wyse Terminal (WindowsCE.NET))
Message-ID: <20040628200134.GA3096@pclin040.win.tue.nl>
References: <20040628123937.3370013B7E9@kweetal.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628123937.3370013B7E9@kweetal.tue.nl>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 12:40:43PM +0000, freaky@bananateam.nl wrote:

> 00000000  eb fe 90 00 00 00 00 00  00 00 00 00 02 08 01 00  |................|
> 00000010  01 00 01 00 00 f0 fa 00  00 00 00 00 00 00 00 00  |................|
> 00000020  00 d0 07 00 00 00 29 1e  00 df 07 50 41 52 54 30  |......)....PART0|
> 00000030  30 20 20 20 20 20 46 41  54 31 36 20 20 20 00 00  |0     FAT16   ..|
> 00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

Ah, yes, I see. Please try the below patch.
(Cut & pasted - tabs will have become spaces.)

Andries


% diff -u -U6 /linux/2.6/linux-2.6.7/linux/fs/fat/inode.c inode.c
--- /linux/2.6/linux-2.6.7/linux/fs/fat/inode.c 2004-06-24 17:11:20
+++ inode.c     2004-06-28 22:03:25
@@ -827,24 +827,26 @@
        if (!b->fats) {
                if (!silent)
                        printk(KERN_ERR "FAT: bogus number of FAT structure\n");
                brelse(bh);
                goto out_invalid;
        }
+#if 0
        if (!b->secs_track) {
                if (!silent)
                        printk(KERN_ERR "FAT: bogus sectors-per-track value\n");
                brelse(bh);
                goto out_invalid;
        }
        if (!b->heads) {
                if (!silent)
                        printk(KERN_ERR "FAT: bogus number-of-heads value\n");
                brelse(bh);
                goto out_invalid;
        }
+#endif
        media = b->media;
        if (!FAT_VALID_MEDIA(media)) {
                if (!silent)
                        printk(KERN_ERR "FAT: invalid media value (0x%02x)\n",
                               media);
                brelse(bh);

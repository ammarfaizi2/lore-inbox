Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbRDQSFX>; Tue, 17 Apr 2001 14:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRDQSFN>; Tue, 17 Apr 2001 14:05:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:23057 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132798AbRDQSFC>;
	Tue, 17 Apr 2001 14:05:02 -0400
Message-ID: <3ADC85A1.4755C87F@linux-m68k.org>
Date: Tue, 17 Apr 2001 20:04:17 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: markh@compro.net
CC: linux-kernel@vger.kernel.org
Subject: Re: amiga affs support broken in 2.4.x kernels??
In-Reply-To: <3AD59EB9.35F3A535@compro.net> <3AD9FEDD.2B636582@linux-m68k.org> <3ADAEA9B.D70DC130@compro.net> <3ADB1837.A0AE3020@linux-m68k.org> <3ADC3262.C97B475@compro.net>
Content-Type: multipart/mixed;
 boundary="------------E38342E706195F62236B2CBE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E38342E706195F62236B2CBE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Mark Hounschell wrote:

>  Sorry I didn't get back to you yesterday afternoon. I was out of town.
>  Attached is the output from dmesg and the relavent info from
> /var/log/messages.

Could you try the attached patch? I forgot to initialize a variable
correctly.
(I also put a new version at
http://www.xs4all.nl/~zippel/affs.010417.tar.gz)

> I beleive the filesystem is ffs
> but not exactly sure. How do I tell?

It's printed if you mount with '-overbose', but it shouldn't be needed
anymore. :)

bye, Roman
--------------E38342E706195F62236B2CBE
Content-Type: text/plain; charset=us-ascii;
 name="affs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="affs.diff"

--- fs/affs/bitmap.c.org	Sat Apr  7 04:23:41 2001
+++ fs/affs/bitmap.c	Tue Apr 17 19:49:18 2001
@@ -124,7 +124,7 @@
 err_bh_read:
 	affs_error(sb,"affs_free_block","Cannot read bitmap block %u", bm->bm_key);
 	AFFS_SB->s_bmap_bh = NULL;
-	AFFS_SB->s_last_bmap = 0;
+	AFFS_SB->s_last_bmap = ~0;
 	up(&AFFS_SB->s_bmlock);
 	return;
 
@@ -262,7 +262,7 @@
 err_bh_read:
 	affs_error(sb,"affs_read_block","Cannot read bitmap block %u", bm->bm_key);
 	AFFS_SB->s_bmap_bh = NULL;
-	AFFS_SB->s_last_bmap = 0;
+	AFFS_SB->s_last_bmap = ~0;
 err_full:
 	pr_debug("failed\n");
 	up(&AFFS_SB->s_bmlock);
@@ -288,6 +288,8 @@
 		return 0;
 	}
 
+	AFFS_SB->s_last_bmap = ~0;
+	AFFS_SB->s_bmap_bh = NULL;
 	AFFS_SB->s_bmap_bits = sb->s_blocksize * 8 - 32;
 	AFFS_SB->s_bmap_count = (AFFS_SB->s_partition_size - AFFS_SB->s_reserved +
 				 AFFS_SB->s_bmap_bits - 1) / AFFS_SB->s_bmap_bits;

--------------E38342E706195F62236B2CBE--


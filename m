Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282906AbRK2T4Q>; Thu, 29 Nov 2001 14:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282623AbRK2T4H>; Thu, 29 Nov 2001 14:56:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41735 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282906AbRK2Tzz>; Thu, 29 Nov 2001 14:55:55 -0500
Message-ID: <3C069291.82E205F1@zip.com.au>
Date: Thu, 29 Nov 2001 11:54:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: viro@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 still not making fs dirty when it should
In-Reply-To: <20011128231504.A26510@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> I still can mount / read/write, press reset, and not get fsck on next
> reboot. That strongly suggests kernel bug to me.

aargh.  I thought that was fixed.  How's this look?

--- linux-2.4.17-pre1/fs/ext2/super.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/ext2/super.c	Thu Nov 29 11:53:52 2001
@@ -311,6 +311,7 @@ static int ext2_setup_super (struct supe
 	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + 1);
 	es->s_mtime = cpu_to_le32(CURRENT_TIME);
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+	ll_rw_block(WRITE, 1, sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
 	if (test_opt (sb, DEBUG))
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "

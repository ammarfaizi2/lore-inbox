Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTDVNbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTDVNbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:31:38 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:5070 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263144AbTDVNbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:31:37 -0400
Date: Tue, 22 Apr 2003 15:42:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andreas Dilger <adilger@clusterfs.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0304221539260.16017-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Marcelo Tosatti wrote:
> Andreas Dilger <adilger@clusterfs.com>:
>   o don't allocate/free blocks in system areas

This change causes a compile warning, cfr. the fix below.

BTW, perhaps `tmp' should be `unsigned int', instead of `int', cfr. the `%u'?

--- linux-2.4.21-rc1/fs/ext2/balloc.c.orig	Tue Apr 22 11:54:53 2003
+++ linux-2.4.21-rc1/fs/ext2/balloc.c	Tue Apr 22 15:39:59 2003
@@ -520,7 +520,7 @@
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
 		      EXT2_SB(sb)->s_itb_per_group)) {
 		ext2_error (sb, "ext2_new_block",
-			    "Allocating block in system zone - block = %lu",
+			    "Allocating block in system zone - block = %u",
 			    tmp);
 		ext2_set_bit(j, bh->b_data);
 		DQUOT_FREE_BLOCK(inode, 1);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



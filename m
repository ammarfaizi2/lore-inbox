Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSHHLRM>; Thu, 8 Aug 2002 07:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSHHLRL>; Thu, 8 Aug 2002 07:17:11 -0400
Received: from Mix-Bordeaux-202-3-168.abo.wanadoo.fr ([193.250.211.168]:384
	"HELO laurent.hivet") by vger.kernel.org with SMTP
	id <S317466AbSHHLRK>; Thu, 8 Aug 2002 07:17:10 -0400
Date: Thu, 8 Aug 2002 13:26:44 +0200 (CEST)
From: "laurent.hivet" <laurent@wanadoo.fr>
X-X-Sender: <laurent@suzy.luce>
To: <linux-kernel@vger.kernel.org>
Subject: fbcon.c with 1024 x 768 linux_logo.h
Message-ID: <Pine.LNX.4.33L2.0208081325230.6802-100000@suzy.luce>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

i'm a very newbie to kernel mailing list for reporting bug.

I use kernel 2.4.19, on SMP pentium III (2 cpu).

I get a panic kernel after booting and before inint script.

I used fblogo-0.4 to get a nice image at startup. I replaced
include/linux/linux_logo.h, and modified fbcon.c with LOGO_H 768 and
LOGO_W 1024.

With previous kernel (2.4.16 ??) not pb.

i decided to use Dan_Boals@Phoenix.com patch:

--- 2.4.19/drivers/video/fbcon.c	Mon Jun 24 16:00:12 2002
+++ 2.4.19/drivers/video/fbcon.c	Mon Jun 24 15:26:18 2002
@@ -688,21 +688,22 @@
     	    	scr_memcpyw(r + step, r, conp->vc_size_row);
     	    	r -= old_cols;
     	    }
     	    if (!save) {
 	    	conp->vc_y += logo_lines;
     		conp->vc_pos += logo_lines * conp->vc_size_row;
     	    }
     	}
     	scr_memsetw((unsigned short *)conp->vc_origin,
 		    conp->vc_video_erase_char,
-		    conp->vc_size_row * logo_lines);
+		    old_cols * logo_lines);
+
     }

     /*
      *  ++guenther: console.c:vc_allocate() relies on initializing
      *  vc_{cols,rows}, but we must not set those if we are only
      *  resizing the console.
      */
     if (init) {
 	conp->vc_cols = nr_cols;
 	conp->vc_rows = nr_rows;

and now all work fine !!

Can someone (maintener but who ?) can verify if this patch is ok and apply
it to fbcon.c in official stable (2.4.x) kernel tree ?

Best Regards.

Laurent HIVET

laurent.hivet@wanadoo.fr



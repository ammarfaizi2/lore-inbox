Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129449AbQK0T6H>; Mon, 27 Nov 2000 14:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129598AbQK0T55>; Mon, 27 Nov 2000 14:57:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:42251 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S129464AbQK0T5r>;
        Mon, 27 Nov 2000 14:57:47 -0500
Date: Mon, 27 Nov 2000 20:27:38 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
Message-ID: <20001127202738.A25168@vana.vc.cvut.cz>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <200011271849.eARInfc255418@saturn.cs.uml.edu> <8vubeq$r5r$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8vubeq$r5r$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Nov 27, 2000 at 11:08:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 11:08:10AM -0800, H. Peter Anvin wrote:

> It would have been somewhat different if there had been a standard
> BIOS function for enabling A20, but there isn't one.
> 
> Sometimes, in the PC world, you just have to draw a line and say "this
> is too broken to use".  I think the original posters' video card falls
> in that category.  Get a new video card, they're cheap these days.

Hi,
  could original complainer (and peoples with AMD SC*) test following
patch? It just does nothing in case that A20 enabled bit is already
set - such as in case when there is nobody listening on 0x92 and
so inb returns 0xFF... (patch is for 2.4.0-test11) 
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux/arch/i386/boot/setup.S.orig	Mon Oct 30 23:44:29 2000
+++ linux/arch/i386/boot/setup.S	Mon Nov 27 20:22:04 2000
@@ -647,8 +647,11 @@
 #	Brown from Linux 2.2
 #
 	inb	$0x92, %al			# 
+	testb   $02, %al
+	jnz     no92
 	orb	$02, %al			# "fast A20" version
 	outb	%al, $0x92			# some chips have only this
+no92:
 
 # wait until a20 really *is* enabled; it can take a fair amount of
 # time on certain systems; Toshiba Tecras are known to have this
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

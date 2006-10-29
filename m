Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWJ2KWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWJ2KWF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 05:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWJ2KWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 05:22:04 -0500
Received: from asia.telenet-ops.be ([195.130.137.74]:13009 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750923AbWJ2KWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 05:22:01 -0500
Date: Sun, 29 Oct 2006 11:21:51 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Geert Uytterhoeven <Geert.Uytterhoeven@telenet.be>
Subject: Re: vmlinux.lds: consolidate initcall sections
In-Reply-To: <1defaf580610271231p37aceacbl6d96f91cf390fc4a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610291120210.5767@anakin>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
 <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org>
 <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com>
 <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org>
 <20061027114144.f8a5addc.akpm@osdl.org> <1defaf580610271231p37aceacbl6d96f91cf390fc4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Haavard Skinnemoen wrote:
> On 10/27/06, Andrew Morton <akpm@osdl.org> wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Add a vmlinux.lds.h helper macro for defining the eight-level initcall
> > table,
> > teach all the architectures to use it.
> 
> Please include AVR32 as well while you're at it ;)

And m68k :-)

Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux/arch/m68k/kernel/vmlinux-std.lds	2006-09-25 22:34:27.000000000 +0200
+++ linux-m68k/arch/m68k/kernel/vmlinux-std.lds	2006-10-29 11:15:18.000000000 +0100
@@ -54,13 +54,7 @@ SECTIONS
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init)
-	*(.initcall2.init)
-	*(.initcall3.init)
-	*(.initcall4.init)
-	*(.initcall5.init)
-	*(.initcall6.init)
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
   __con_initcall_start = .;
--- linux/arch/m68k/kernel/vmlinux-sun3.lds	2006-09-25 22:34:27.000000000 +0200
+++ linux-m68k/arch/m68k/kernel/vmlinux-sun3.lds	2006-10-29 11:14:50.000000000 +0100
@@ -48,13 +48,7 @@ __init_begin = .;
 	__setup_end = .;
 	__initcall_start = .;
 	.initcall.init : {
-		*(.initcall1.init)
-		*(.initcall2.init)
-		*(.initcall3.init)
-		*(.initcall4.init)
-		*(.initcall5.init)
-		*(.initcall6.init)
-		*(.initcall7.init)
+		INITCALLS
 	}
 	__initcall_end = .;
 	__con_initcall_start = .;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

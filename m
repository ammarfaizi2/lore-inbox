Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264252AbRFDNXC>; Mon, 4 Jun 2001 09:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264245AbRFDNLJ>; Mon, 4 Jun 2001 09:11:09 -0400
Received: from rs6000.univie.ac.at ([131.130.1.14]:17931 "EHLO
	rs6000.univie.ac.at") by vger.kernel.org with ESMTP
	id <S264244AbRFDNKw>; Mon, 4 Jun 2001 09:10:52 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
Message-Id: <200106041441.02167@pflug3.gphy.univie.ac.at>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH: tdfxfb: bugfix & enable SUN12x22 font, kernel 2.4.5
Date: Mon, 4 Jun 2001 15:08:51 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        linux-fbdev@vuser.vu.union.edu, Hannu MALLAT <hmallat@cc.hut.fi>
In-Reply-To: <Pine.LNX.4.05.10106041418020.28576-100000@callisto.of.borg>
In-Reply-To: <Pine.LNX.4.05.10106041418020.28576-100000@callisto.of.borg>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RUPEXWAV9PO794R2BOUV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RUPEXWAV9PO794R2BOUV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

* Geert Uytterhoeven -- Monday 04 June 2001 14:20:
> On Mon, 4 Jun 2001, Melchior FRANZ wrote:
> > The attached patch fixes that bug and enables 8--12 bit wide fonts, thus
> > disabling the "No support ..." messages. I haven't found an indication that
> 
> Does it work now for fonts with width 16? I'd expect so.

It works for 8 and 12 pixels wide fonts on my 80686 little-endian. I don't have
a 16 pixel font, but such a font should even have worked with the bug, because
like with a 8 bit font the pattern would by fortune have come out right.



> BTW, instead of using #ifdef __LITTLE_ENDIAN and swapping explicitly, it's
> better to use the cpu_to_be* macros.

I see. I just grepped through some source files and saw these ifdef's everywhere,
so I didn't feel especially guilty.  ;-)



> > there are any Voodoo3/Banshee cards for big endian machines. The bugfix implies
> > that they never could have worked. (But if they have indeed, they would be
> > broken after applying the patch. Could someone comment on this, please?)
> 
> Yes, people are using Voodoo3 boards on PPC. But they require(d) some patches,
> IIRC.

Ahh. Maybe someone with a PPC could test that patch. New version (without ifdef)
attached.

m.


PS: My emails don't seem to make it to the kernel-list. Or is a delay of more
    than two hours considered normal?! Now I'm trying via a smart-host ...

--------------Boundary-00=_RUPEXWAV9PO794R2BOUV
Content-Type: text/plain;
  charset="iso-8859-1";
  name="tdfxfb.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="tdfxfb.diff"

--- linux-2.4.5/drivers/video/tdfxfb.c	Sun Jun  3 17:13:30 2001
+++ linux/drivers/video/tdfxfb.c	Mon Jun  4 14:54:59 2001
@@ -1207,7 +1207,7 @@
    revc:		tdfx_cfbX_revc,   
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 16)
 };
 #endif
 #ifdef FBCON_HAS_CFB16
@@ -1220,7 +1220,7 @@
    revc:		tdfx_cfbX_revc, 
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 16)
 };
 #endif
 #ifdef FBCON_HAS_CFB24
@@ -1233,7 +1233,7 @@
    revc:		tdfx_cfbX_revc, 
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 16)
 };
 #endif
 #ifdef FBCON_HAS_CFB32
@@ -1246,7 +1246,7 @@
    revc:		tdfx_cfbX_revc, 
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 16)
 };
 #endif
 
@@ -2314,7 +2314,7 @@
    unsigned int h,to;
 
    tdfxfb_createcursorshape(p);
-   xline = (1 << fb_info.cursor.w)-1;
+   xline = cpu_to_be32(~((1 << (32 - fb_info.cursor.w)) - 1));
    cursorbase=(u8*)fb_info.bufbase_virt;
    h=fb_info.cursor.cursorimage;     
    

--------------Boundary-00=_RUPEXWAV9PO794R2BOUV
Content-Type: text/plain;
  charset="iso-8859-1";
  name="README"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="README"

tdfxfb.c: fix cursor bug; enable 12x22 fonts  -- Melchior FRANZ <a8603365@unet.univie.ac.at>

--------------Boundary-00=_RUPEXWAV9PO794R2BOUV--

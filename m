Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTCDVgR>; Tue, 4 Mar 2003 16:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTCDVgR>; Tue, 4 Mar 2003 16:36:17 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:62849 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261353AbTCDVgQ>;
	Tue, 4 Mar 2003 16:36:16 -0500
Date: Tue, 4 Mar 2003 22:46:32 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Message-ID: <20030304214632.GA1756@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz> <20030304212906.GA1115@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304212906.GA1115@middle.of.nowhere>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 10:29:06PM +0100, Jurriaan wrote:
> > text mode.
> 
> There is a regression here: I boot my kernel like this:
> 
> kernel /boot/vmlinuz-2563matrox root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=smp apm=power-off nosmp=1
> 
> I see a continuous strip of alternating blocks, of sub-character size,
> at the extreme right end of my screen. The colors seem linked to the
> color of the line with the cursor in some way.
> 
> After leaving XFRee, a piece of chbg's background picture is shown for a
> short while, then the blocks return.

Reproduced. Try this (untested) (it is against clean tree, so you'll 
get some line offsets if you had applied my matroxfb patch). Or set 
xres to odd value, even values do not work...
							Petr Vandrovec


--- linux/drivers/video/console/fbcon.c	2003-03-03 18:42:37.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2003-03-04 22:44:05.000000000 +0100
@@ -456,7 +456,7 @@
 	region.color = attr_bgcol_ec(p, vc);
 	region.rop = ROP_COPY;
 
-	if (rw & !bottom_only) {
+	if (rw && !bottom_only) {
 		region.dx = info->var.xoffset + rs;
 		region.dy = 0;
 		region.width = rw;

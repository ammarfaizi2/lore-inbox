Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTCDVnU>; Tue, 4 Mar 2003 16:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCDVnU>; Tue, 4 Mar 2003 16:43:20 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:7134 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261456AbTCDVnS>;
	Tue, 4 Mar 2003 16:43:18 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: thunder7@xs4all.nl
Date: Tue, 4 Mar 2003 22:53:13 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux@mailgw.cvut.cz, Fbdev@mailgw.cvut.cz, development@mailgw.cvut.cz,
       "list <linux-fbdev-"@vc.cvut.cz
X-mailer: Pegasus Mail v3.50
Message-ID: <11D5C9495B88@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Mar 03 at 22:46, Petr Vandrovec wrote:
> On Tue, Mar 04, 2003 at 10:29:06PM +0100, Jurriaan wrote:
> > > text mode.
> > 
> > There is a regression here: I boot my kernel like this:
> > 
> > kernel /boot/vmlinuz-2563matrox root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=smp apm=power-off nosmp=1
> > 
> > I see a continuous strip of alternating blocks, of sub-character size,
> > at the extreme right end of my screen. The colors seem linked to the
> > color of the line with the cursor in some way.
> > 
> > After leaving XFRee, a piece of chbg's background picture is shown for a
> > short while, then the blocks return.
> 
> Reproduced. Try this (untested) (it is against clean tree, so you'll 
> get some line offsets if you had applied my matroxfb patch). Or set 
> xres to odd value, even values do not work...
>                             Petr Vandrovec
> 
> 
> --- linux/drivers/video/console/fbcon.c 2003-03-03 18:42:37.000000000 +0100
> +++ linux/drivers/video/console/fbcon.c 2003-03-04 22:44:05.000000000 +0100
> @@ -456,7 +456,7 @@
>     region.color = attr_bgcol_ec(p, vc);
>     region.rop = ROP_COPY;
>  
> -   if (rw & !bottom_only) {
> +   if (rw && !bottom_only) {
>         region.dx = info->var.xoffset + rs;
>         region.dy = 0;
>         region.width = rw;
> -

It will not solve problem that you'll get non-black edge if your
background color is not black... I'll try to invent some solution,
like ROP_ZERO...
                                            Petr
                                            


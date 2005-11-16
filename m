Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbVKPAGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVKPAGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 19:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVKPAGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 19:06:12 -0500
Received: from mailfe06.tele2.fr ([212.247.154.172]:33505 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S965094AbVKPAGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 19:06:11 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Wed, 16 Nov 2005 01:05:49 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Jason Dravet <dravet@hotmail.com>
Cc: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051116000549.GC5080@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jason Dravet <dravet@hotmail.com>, 7eggert@gmx.de,
	adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
	davej@redhat.com, linux-kernel@vger.kernel.org
References: <E1EbaZH-0000cM-LC@be1.lrz> <BAY103-F21A2AF88D83C3CE3CAEE19DF5A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY103-F21A2AF88D83C3CE3CAEE19DF5A0@phx.gbl>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jason Dravet, le Mon 14 Nov 2005 09:27:51 -0600, a écrit :
> >Jason Dravet <dravet@hotmail.com> wrote:
> >
> >> When I run stty rows 20 I get a screen of 80x20.  I can see the top 10 
> >rows
> >> and the bottom 10 rows are invisible.
> >
> >I asume your VGA indicates that it'll divide it's scanline counter by 2.
> >Please add a printk("vgacon: mode=%2.2x\n", mode) before line 512 and 
> >report
> >the value. A real fix will depend on this value. In the meantime, removing
> >the lines 512 and 513 from the original file should be a temporary fix.
> 
> Here is the result from the printk you requested:
> vgacon: mode=a3
> 
> I commented out lines 512 and 513 and the problem remains.

Really strange...

At that same line, could you try adding this:

printk("vgacon: y=%d fonth=%d deffh=%d vidfh=%d scanl=%d\n", height, c->vc_font.height, vga_default_font_height, vga_video_font_height, vga_scan_lines);
outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
printk("vgacon: overflow %02x\n",inb_p(vga_video_port_val));
outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
printk("vgacon: vsync_end %02x\n",inb_p(vga_video_port_val));
outb_p(VGA_CRTC_V_DISP_END, vga_video_port_reg);
printk("vgacon: vdisp_end %02x\n",inb_p(vga_video_port_val));

Regards,
Samuel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVKPBuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVKPBuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVKPBuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:50:40 -0500
Received: from bay103-f14.bay103.hotmail.com ([65.54.174.24]:24369 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965158AbVKPBuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:50:40 -0500
Message-ID: <BAY103-F149222EE61B1B5CD0FBE86DF5C0@phx.gbl>
X-Originating-IP: [70.131.121.157]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20051116000549.GC5080@bouh.residence.ens-lyon.fr>
From: "Jason Dravet" <dravet@hotmail.com>
To: samuel.thibault@ens-lyon.org
Cc: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Date: Tue, 15 Nov 2005 19:50:39 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Nov 2005 01:50:39.0719 (UTC) FILETIME=[257D7770:01C5EA50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Samuel Thibault <samuel.thibault@ens-lyon.org>
>To: Jason Dravet <dravet@hotmail.com>
>CC: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, 
>akpm@osdl.org,davej@redhat.com, linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
>Date: Wed, 16 Nov 2005 01:05:49 +0100
>
>Hi,
>
>Jason Dravet, le Mon 14 Nov 2005 09:27:51 -0600, a écrit :
> > >Jason Dravet <dravet@hotmail.com> wrote:
> > >
> > >> When I run stty rows 20 I get a screen of 80x20.  I can see the top 
>10
> > >rows
> > >> and the bottom 10 rows are invisible.
> > >
> > >I asume your VGA indicates that it'll divide it's scanline counter by 
>2.
> > >Please add a printk("vgacon: mode=%2.2x\n", mode) before line 512 and
> > >report
> > >the value. A real fix will depend on this value. In the meantime, 
>removing
> > >the lines 512 and 513 from the original file should be a temporary fix.
> >
> > Here is the result from the printk you requested:
> > vgacon: mode=a3
> >
> > I commented out lines 512 and 513 and the problem remains.
>
>Really strange...
>
>At that same line, could you try adding this:
>
>printk("vgacon: y=%d fonth=%d deffh=%d vidfh=%d scanl=%d\n", height, 
>c->vc_font.height, vga_default_font_height, vga_video_font_height, 
>vga_scan_lines);
>outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
>printk("vgacon: overflow %02x\n",inb_p(vga_video_port_val));
>outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
>printk("vgacon: vsync_end %02x\n",inb_p(vga_video_port_val));
>outb_p(VGA_CRTC_V_DISP_END, vga_video_port_reg);
>printk("vgacon: vdisp_end %02x\n",inb_p(vga_video_port_val));
>
>Regards,
>Samuel

Here are the results:
y=25   fonth=16   deffh=16   vidfh=16   scanl=400
overflow=ff
vsync_end=8f
vdisp_end=1f

Thanks,
Jason



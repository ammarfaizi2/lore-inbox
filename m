Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275381AbTHIVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275403AbTHIVIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:08:09 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:63918 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S275381AbTHIVID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:08:03 -0400
Subject: Re: 2.6.0-test2 does not boot with matroxfb
From: 520091033440-0001@t-online.de (Juergen Rose)
Reply-To: rose@rz.uni-potsdam.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: University of Potsdam
Message-Id: <1060463270.1129.25.camel@mousehomenet.homenet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 09 Aug 2003 23:07:51 +0200
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: GhMHxTZEoeM4DuuCGf2dk4adUy3neyyc-qvgVIeAIeyJbQZ1Fm5ywr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Fri, 2003-08-08 at 18:16, Petr Vandrovec wrote: 
> On  8 Aug 03 at 17:45, Juergen Rose wrote:
> > I tried on my PC with a Matrox-G450 several kernel and boot options.
> > Every time when the console should work with matrox framebuffer, linux
> > was crashed. With 2.6.0-test2 and 2.6.0-test2-bk7 I had the following
> > warning performing ''make modules_install''
> > WARNING:
> > /lib/modules/2.6.0-test2[-bk7]/kernel/drivers/video/matrox/matroxfb_crtc2.ko
> > needs unknown symbol matroxfb_enable_irq This WARNING disapears for
> 
> I'm not able to get through Linus's mail filters for past three weeks.
> 
> > 2.4.22-pre6-ac1             |         |               |
> > CONFIG_FB=y                 | VGA=6   |  VGA=775      | vesa:0x31C
> > CONFIG_VIDEO_SELECT=y       |         |               |
> > --+--+--+--
> > 2.6.0-test2                 |         |crashes        |crashes        
> > CONFIG_FRAMEBUFFER_CONSOLE=y|  VGA=6  |after          |after          
> > CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK
> 
> What means this? No useful data here... Oopses? Reboot?
> Endless loop? And did you built vgacon into the kernel? And I'm
> not sure that 2.6.0 can have both vesafb & matroxfb compiled in (well,
> you can compile in both, but I'm not sure what happens).

Sorry, that I did not explain more detailed. "crashes after BIOS DATA
CHECK" means, that "BIOS DATA CHECK" was the last, what I have seen,
then I got a blank screen. For some configurations I still waited
several minutes to see, if it is possible to ping from another PC to the
PC with 2.6.0-test2. But I did not get a connection, so I had to perform
a hard reset with 2.6.0-test2-PC.

> And from your message above it looks like that you are building some 
> vital matroxfb portions as a module. Please build them into the kernel 
> unless you are really sure that you do not want console on them - while 
> 2.4.x's console could use modular fbdevs, 2.6.x's console subsytem 
> cannot do that. 

'grep -i matrox amd4GBaic7xxx_ideHPT_noacpi_noapic_ess1371.cfg' (which
was my .config) gives
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_MATROX_PROC is not set
CONFIG_FB_MATROX_MULTIHEAD=y

'grep -i "fb.*=[my]" amd4GBaic7xxx_ideHPT_noacpi_noapic_ess1371.cfg'
gives besides MATROS lines:
CONFIG_FB=y
CONFIG_FB_VESA=y
...
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA=y
CONFIG_FBCON_HGA=m
CONFIG_FBCON_FONTS=y

So I will set CONFIG_FB_MATROX and CONFIG_FB_MATROX_I2C to yes, and
build a new kernel at monday.

> You can also try ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz
> (if 2.6.0-test2-mm5 does not complain about unexported matrox_*_irq
> it will probably not apply cleanly to it). It restores fbcon subsystem
> to the 2.4.x's version.
>                                             Petr
>                                             
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


	Juergen

-- 
Juergen Rose <rose@rz.uni-potsdam.de>
University of Potsdam


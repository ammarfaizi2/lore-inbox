Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271419AbTHHQQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271420AbTHHQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:16:57 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:200 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271419AbTHHQQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:16:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Juergen Rose <rose@rz.uni-potsdam.de>
Date: Fri, 8 Aug 2003 18:16:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test2 does not boot with matroxfb
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <98F7C261951@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 03 at 17:45, Juergen Rose wrote:
> I tried on my PC with a Matrox-G450 several kernel and boot options.
> Every time when the console should work with matrox framebuffer, linux
> was crashed. With 2.6.0-test2 and 2.6.0-test2-bk7 I had the following
> warning performing ''make modules_install''
> WARNING:
> /lib/modules/2.6.0-test2[-bk7]/kernel/drivers/video/matrox/matroxfb_crtc2.ko
> needs unknown symbol matroxfb_enable_irq This WARNING disapears for

I'm not able to get through Linus's mail filters for past three weeks.

> 2.4.22-pre6-ac1             |         |               |
> CONFIG_FB=y                 | VGA=6   |  VGA=775      | vesa:0x31C
> CONFIG_VIDEO_SELECT=y       |         |               |
> ----------------------------+---------+---------------+---------------
> 2.6.0-test2                 |         |crashes        |crashes        
> CONFIG_FRAMEBUFFER_CONSOLE=y|  VGA=6  |after          |after          
> CONFIG_VIDEO_SELECT=y       |         |BIOS DATA CHECK|BIOS DATA CHECK

What means this? No useful data here... Oopses? Reboot?
Endless loop? And did you built vgacon into the kernel? And I'm
not sure that 2.6.0 can have both vesafb & matroxfb compiled in (well,
you can compile in both, but I'm not sure what happens).

And from your message above it looks like that you are building some 
vital matroxfb portions as a module. Please build them into the kernel 
unless you are really sure that you do not want console on them - while 
2.4.x's console could use modular fbdevs, 2.6.x's console subsytem 
cannot do that. 

You can also try ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz
(if 2.6.0-test2-mm5 does not complain about unexported matrox_*_irq
it will probably not apply cleanly to it). It restores fbcon subsystem
to the 2.4.x's version.
                                            Petr
                                            


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbSJNSbc>; Mon, 14 Oct 2002 14:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262069AbSJNSbb>; Mon, 14 Oct 2002 14:31:31 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:31706 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262065AbSJNSb3>;
	Mon, 14 Oct 2002 14:31:29 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Mon, 14 Oct 2002 20:36:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should n
Cc: "Adam J. Richter" <adam@yggdrasil.com>, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       ebiederm@xmission.com
X-mailer: Pegasus Mail v3.50
Message-ID: <49A685A38EF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Oct 02 at 13:48, Richard B. Johnson wrote:
> > > itself as random of other programs, not getting through the reboot
> > > process half of the time, etc.
> >
> 
> A processor reset will get the processor onto the bus even if there is
> an ongoing DMA operation. Since the first of many instructions are
> fetched from ROM, it is quite likely that any DMA activity would have
> stopped before the ROM is shadowed by the BIOS. I don't see "ongoing"
> DMA as being a problem, which you can verify by forcing a reset in
> the FDC code (easiest to do) while waiting for read DMA to complete.
> FDC DMA is slow, so you can catch it 100% of the time.

Not all DMA transfer finishes in finite time. When I have enabled
picture feed to videoram on LML33 I have here in my dual AMD, nothing 
is going to stop transfer: it will happilly feed data during soft
reboot. Either computer will refuse to boot completely because of 
videobios will not be able to initialize videoram (Hey, you have
with no usable video memory, all write-verify cycles failed: returned
data differ from written one. Please add some memory chips...),
or you'll see garbage on screen until device's busmastering bit
is disabled (when LML33 driver is loaded...).

Only problem is when you are going to disable busmastering: like
we have early printk console, we need its counterpart on shutdown,
as PCI video drivers can be unloaded long before other drivers finish
unloading (== poweroff does not work on my system for some time. 
I assume that it oopses somewhere after matroxfb shutdown), and
after shutting down PCI-AGP bridge no message can find its way to
the screen, even with any early printk solution...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVLaUum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVLaUum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVLaUul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:50:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45261 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932318AbVLaUul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:50:41 -0500
Date: Sat, 31 Dec 2005 21:50:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jason Dravet <dravet@hotmail.com>
cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: RFC: add udev support to parport_pc
In-Reply-To: <BAY103-F3438FAEB6A51CC5567D48DDF2B0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0512312145290.27366@yvahk01.tjqt.qr>
References: <BAY103-F3438FAEB6A51CC5567D48DDF2B0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I would prefer to actually see == 0x378 in the code, because the
>> hexademical number is what you see everywhere else, such as the BIOS POST
>> and /proc/ioports. This also applies to 0x278 and 0x3BC below.
>> 
> This is what I wanted but I could not figure out how do it.  If you tell me how
> I will be happy to change it.  I tried  if (p->base == 0x378) but then
> class_device_create does not get executed.
>
Sounds very strange to me that by changing a base-10 integer into base-16 
does not execute the branch anymore...

>> Background info before: Because I burnt my on-board LPT port (applying too
>> much volts or milliamps), I bought a dual-slot PCI add-in card. This card
>> provides "parport1" and "parport2" at ports at 0xC800 and 0xC00
>> (/proc/ioports).
>> 
> The last experience I have with off board cards was about 5 years ago.  The
> choices for the two parallel ports were 378, 278, or 3BC.  I was not aware that
> you had flexibility now.
>
Well, I can tell you even more: I also have an ISA LPT expansion card in an 
ol 386 that gets assigned 278 and 3BC respectively.


> As I said above I was not aware todays off board parallel ports had more
> choices.  I will see what I can do to fix this.  Do you have any suggestions?

I have not yet checked the BIOS POST message of the i686 where
the PCI LPT card is in... maybe it's just Linux that remaps
it to high ports. Gotta test it in Windows. BBL.

Anyway, as for the patch I think you should walk down the list of 
already-collected ioports (in userspace that would equal to `grep parport 
/proc/ioports`) and assign each of them consecutive device names.




Jan Engelhardt
-- 

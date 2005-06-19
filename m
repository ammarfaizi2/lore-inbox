Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFSL0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFSL0D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 07:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVFSL0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 07:26:03 -0400
Received: from mail.linicks.net ([217.204.244.146]:54801 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261192AbVFSLZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 07:25:54 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2 errors in 2.6.12
Date: Sun, 19 Jun 2005 12:25:50 +0100
User-Agent: KMail/1.8.1
References: <200506191104.28900.nick@linicks.net>
In-Reply-To: <200506191104.28900.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506191225.50522.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 June 2005 11:04, you wrote:
> >and my SBLive! plays only on 2 repros Front left and right.
>
> Yes - I noticed something with my SB Live.  I thought it was me, but going
> through everythnig this morning, I don't think it is.
>
> From 2.6.11.12 dmesg:
>
> Jun 17 18:39:45 linuxamd kernel: Advanced Linux Sound Architecture Driver
> Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
> Jun 17 18:39:45 linuxamd kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI
> 5 (level, low) -> IRQ 5
> Jun 17 18:39:45 linuxamd kernel: ALSA device list:
> Jun 17 18:39:45 linuxamd kernel:   #0: Sound Blaster Live! (rev.7,
> serial:0x80611102) at 0xe000, irq 5
>
> And here from new 2.6.12 dmesg:
>
> Jun 18 15:27:41 linuxamd kernel: Advanced Linux Sound Architecture Driver
> Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
> Jun 18 15:27:41 linuxamd kernel: PCI: Found IRQ 5 for device 0000:00:0f.0
> Jun 18 15:27:41 linuxamd kernel: ALSA device list:
> Jun 18 15:27:41 linuxamd kernel:   #0: SB Live [Unknown] (rev.7,
> serial:0x80611102) at 0xe000, irq 5

OK, I have found out why - an alsa-devel patch changed to be more specific on 
the chipset/model - more here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111209948526203&w=2

It turns out my card isn't in the ID list, so it gets given an 'unknown'.  As 
this changed from 2.6.11.12, alsamixer then reset (effectively a new card!) 
so I had to reset all my mixer settings again - I would look at your mixer 
settings for the surround sound settings (mute etc.).

Here is a page with the ID and chipsets of the cards:

http://www.digit-life.com/articles/livetolive51/

I am going to attempt to add my card into emu10k1_main.c to get it set right:

0 [Unknown        ]: EMU10K1 - SB Live [Unknown]
                     SB Live [Unknown] (rev.7, serial:0x80611102) at 0xe000, 
irq 5

>From that 'livetolive51' page I am told I have:
SB0060 - SBlive! Value (PCI\VEN_1102&DEV_0002&SUBSYS_80611102)

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

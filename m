Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293647AbSB1U0y>; Thu, 28 Feb 2002 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293088AbSB1UZT>; Thu, 28 Feb 2002 15:25:19 -0500
Received: from nixpbe.pdb.sbs.de ([192.109.2.33]:64747 "EHLO nixpbe.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S293712AbSB1UZE>;
	Thu, 28 Feb 2002 15:25:04 -0500
Date: Thu, 28 Feb 2002 21:28:13 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: PROBLEM: Timer interrupt lockup on HT machine
In-Reply-To: <Pine.LNX.4.33.0202281339290.24779-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.33.0202282120190.25655-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have looked into this some more.

It appears that the mask register of the 8259 PIC is corrupted.
On this machine, the timer is setup through setup_ExtINT_IRQ0_pin()
(8259A master -> IRQ broadcast), all is working well.

The correct value of the mask register (IO port 0x21) should be 0xfa
(Timer & cascade enabled).

When the timer lockup happens, the register value is 0x07, i.e.
completely wrong, and IRQ 0 is masked. I can use a user space
program to re-eneable the timer interrupt, and all is fine again.

I am pretty irritated by this behaviour, because in the timer
operating mode on this system the mask register is never accessed
after the initial setup.

It is very obvious that this situation arises around the time of X
server startup.

Any clues?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy






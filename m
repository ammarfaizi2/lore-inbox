Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289101AbSAOBBw>; Mon, 14 Jan 2002 20:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289329AbSAOBBm>; Mon, 14 Jan 2002 20:01:42 -0500
Received: from [195.65.217.180] ([195.65.217.180]:33412 "EHLO
	musistation.amazing.ch") by vger.kernel.org with ESMTP
	id <S289101AbSAOBBj>; Mon, 14 Jan 2002 20:01:39 -0500
Date: Tue, 15 Jan 2002 02:04:13 +0100
From: Christoph Dworzak <linuxkernel@amazing.ch>
To: linux-kernel@vger.kernel.org
Cc: tulip@scyld.com
Subject: 2.4.17 tulip multiport-patch
Message-ID: <20020115020413.B11753@amazing.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

After lots of Headscratching, I found this little bug:

replace line 1642 of tulip_core.c:

		    irq = last_irq;

with

		    dev->irq = irq = last_irq;


It's a hack for Multiport-NICs where only the first one contains
an EEPROM (I have a Adaptec ANA-6944A/TX). It puts other ports
on the same irq as the first one, but it forgot to actually set
it in the dev-structure...

With this correction my Firewall works like a champ now (before
it crashed immediately when activating the second port of the
multiport-nic).


While searching for this Bug, I also tried the de4x5-driver.
It worked, but with troubles. It sets the MAC-Address of all
the other ports to the MAC of the first port + 1. ALL of them
to the same MAC!
I tried to find out why, but I didn't find this in the code
(I found where it adds this 1, but didn't see why it doesn't
increase it further for further ports...)



Don't know if this is related:
While using the de4x5-driver, my system-load climbed steadily
up. After 3 Days it was at 99.5%.

Top didn't show any processes using this time, but the Computer
was reaaaaaly slow (pressing a key took several seconds until
it appeared on the console...)

This was repeatable. -> Reboot every other day :(

If this happens again, how do I find out what's using the CPU?
(I tried top, vmstat, free, but nothing unusual showed up beside
the system-% in top).


bye
 dworz

Config (two Computers A and B):
A Amd-k6/300, 64MB
B Dual PIII-600, 512MB
both with ANA-6944A/TX + 2 other tulips
both RH7.2 with all updates as of 1.1.02
kernel 2.4.9-13 (the tulip-bug is still in 2.4.18pre3)

Computer B would not slow down with DE4x5, but maybe it wasn't
running long enough yet...
Both crashed with tulip.

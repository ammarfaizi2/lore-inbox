Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSA2CNQ>; Mon, 28 Jan 2002 21:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSA2CNG>; Mon, 28 Jan 2002 21:13:06 -0500
Received: from h225-81.adirondack.albany.edu ([169.226.225.80]:7606 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S287149AbSA2CNB>;
	Mon, 28 Jan 2002 21:13:01 -0500
Subject: Re: via-rhine timeouts
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Cc: Urban Widmark <urban@teststation.com>
In-Reply-To: <Pine.LNX.4.33.0201261559580.4687-200000@cola.teststation.com>
In-Reply-To: <Pine.LNX.4.33.0201261559580.4687-200000@cola.teststation.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 28 Jan 2002 21:13:27 -0500
Message-Id: <1012270407.22269.0.camel@bouncybouncy.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I re-addressed the email...the CC's got out of hand...

On Sat, 2002-01-26 at 10:21, Urban Widmark wrote:
> 
> Hello, troubled via-rhine users ...
> 
> The attached patch vs 2.4.17 is a merge of bits from various sources. It
> contains useful stuff such as turning on bit2 in the cards PCI
> configuration register 0x53 (undocumented).
> 
> Please test this and see if the problems go away. Note that this version
> reports a little more information, so send 'dmesg' output even of you 
> sent it before.
> 

Ok, it was working for a while, even after a reboot...
but now
 21:04:33 up 2 days, 20 min, 10 users,  load average: 0.12, 0.47, 0.38

Jan 28 01:39:10 bouncybouncy kernel: eth0: Transmitter underflow?,
status 2008.
Jan 28 01:39:20 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 28 01:39:20 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY status 782d, resetting...
Jan 28 01:39:20 bouncybouncy kernel: eth0: reset finished after 5
microseconds.
Jan 28 02:23:22 bouncybouncy kernel: eth0: Transmitter underflow?,
status 2008.
Jan 28 02:23:26 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 28 02:23:26 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY status 782d, resetting...
Jan 28 02:23:26 bouncybouncy kernel: eth0: reset finished after 5
microseconds.

This went unnoticed earlier.... until it happened again:

Jan 28 20:26:03 bouncybouncy kernel: eth0: Transmitter underflow?,
status 2008.
Jan 28 20:26:06 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 28 20:26:06 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY status 782d, resetting...
Jan 28 20:26:06 bouncybouncy kernel: eth0: reset finished after 10005
microseconds.

That repeated over and over again(every 30 seconds or so) until I got
back:

grep "Jan 28.*eth0" /var/log/messages|wc -l
    328
After reloading the driver it started working again:

linuxfet.c : v3.23 05/15/2001
  The PCI BIOS has not enabled the device at 0/144!  Updating PCI
command 0003->0007.
eth0: VIA PCI 10/100Mb Fast Ethernet Adapter                      
eth0: IO Address = 0xe800, MAC Address = 00:50:2c:01:64:a9, IRQ = 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
0021.
eth0: netdev_open() irq 11.
eth0: Done netdev_open(), status 881a MII status: 782d.

I think that last message might be a clue on why this is happening...

-- 
-Justin

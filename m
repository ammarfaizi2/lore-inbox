Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVJWJsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVJWJsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVJWJsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 05:48:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44708 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750836AbVJWJsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 05:48:19 -0400
Date: Sun, 23 Oct 2005 11:48:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Message-ID: <20051023094806.GB1975@elf.ucw.cz>
References: <20051022173152.GA2573@elf.ucw.cz> <1130059941.11428.81.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130059941.11428.81.camel@blade>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ping time is around 50msec, and that seems pretty much okay, but
> > 10KB/sec seems like way too low.
> > 
> > I am limited to 10KB/sec both on linux-to-linux bnetp transfers and it
> > limits my transfer rates using edge and n6230, too :-(.
> 
> so you say that the Nokia 6230 has PAN Profile support and you don't
> need any PPP crap to get Internet access? This would be the first phone
> I have seen so far.

No, sorry, that was over ppp over rfcomm. With MSI dongle, I get
25KB/sec with n6230. With bluetooth CF card, I only get 10KB/sec.

> > 64 bytes from 10.1.0.3: icmp_seq=181 ttl=64 time=11789.1 ms
> > 64 bytes from 10.1.0.3: icmp_seq=182 ttl=64 time=10784.9 ms
> > 64 bytes from 10.1.0.3: icmp_seq=183 ttl=64 time=9781.1 ms
> 
> The initial pings look good, the rest is very bad.

Rest is during transfer. I'd expect it to be slightly worse, but not
that bad.

> > Netdev watchdog complains a lot:
> > 
> > Oct 22 18:53:57 amd pand[2439]: Bluetooth PAN daemon version 2.19
> > Oct 22 18:53:57 amd pand[2439]: Connecting to <won't tell you>
> > Oct 22 18:53:58 amd pand[2439]: bnep0 connected
> > Oct 22 18:54:37 amd kernel: usb 3-1: USB disconnect, address 2
> > Oct 22 18:55:33 amd kernel: NETDEV WATCHDOG: bnep0: transmit timed out
> > Oct 22 18:55:59 amd last message repeated 2 times
> > Oct 22 18:56:51 amd last message repeated 5 times
> > Oct 22 18:57:55 amd last message repeated 3 times
> > Oct 22 18:59:03 amd last message repeated 7 times
> 
> The transmit timeouts shouldn't be there. The question is now which side
> is at fault. The host or the phone?

This is against second linux box... Can't be the phone.

> Please do a "hcitool info <won't tell you>" as root so I can see which
> what chip we are dealing. Also "hciconfig hci0 version" for your card
> would help.

On billionton card:

root@spitz:/bt# hcitool info <address of MSI card>
Requesting information ...
        BD Address:  <address of MSI card>
        Device Name: BlueZ (0)
        LMP Version: 1.1 (0x1) LMP Subversion: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>
root@spitz:/bt# hciconfig hci0 version
hci0:   Type: UART
        BD Address: <address of billionton> ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)
root@spitz:/bt#

On MSI side:

root@bug:~# hcitool info <address of billionton>
Requesting information ...
        BD Address:  <address of billionton>
        Device Name: billionton
        LMP Version: 1.1 (0x1) LMP Subversion: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>
root@bug:~#

> You can also use "hcidump -X -V" to analyze the traffic.

Do you prefer hcidump on MSI or on billionton side? On MSI side it is
easy to get, but it is generating *big* logs.
								Pavel
-- 
Thanks, Sharp!

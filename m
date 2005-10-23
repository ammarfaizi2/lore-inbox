Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVJWKJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVJWKJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVJWKJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:09:43 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:61313 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751442AbVJWKJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:09:43 -0400
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051023094806.GB1975@elf.ucw.cz>
References: <20051022173152.GA2573@elf.ucw.cz>
	 <1130059941.11428.81.camel@blade>  <20051023094806.GB1975@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 12:10:04 +0200
Message-Id: <1130062204.11428.86.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > > Ping time is around 50msec, and that seems pretty much okay, but
> > > 10KB/sec seems like way too low.
> > > 
> > > I am limited to 10KB/sec both on linux-to-linux bnetp transfers and it
> > > limits my transfer rates using edge and n6230, too :-(.
> > 
> > so you say that the Nokia 6230 has PAN Profile support and you don't
> > need any PPP crap to get Internet access? This would be the first phone
> > I have seen so far.
> 
> No, sorry, that was over ppp over rfcomm. With MSI dongle, I get
> 25KB/sec with n6230. With bluetooth CF card, I only get 10KB/sec.

show me the "hcitool info ..." for the phone.

> > > 64 bytes from 10.1.0.3: icmp_seq=181 ttl=64 time=11789.1 ms
> > > 64 bytes from 10.1.0.3: icmp_seq=182 ttl=64 time=10784.9 ms
> > > 64 bytes from 10.1.0.3: icmp_seq=183 ttl=64 time=9781.1 ms
> > 
> > The initial pings look good, the rest is very bad.
> 
> Rest is during transfer. I'd expect it to be slightly worse, but not
> that bad.
> 
> > > Netdev watchdog complains a lot:
> > > 
> > > Oct 22 18:53:57 amd pand[2439]: Bluetooth PAN daemon version 2.19
> > > Oct 22 18:53:57 amd pand[2439]: Connecting to <won't tell you>
> > > Oct 22 18:53:58 amd pand[2439]: bnep0 connected
> > > Oct 22 18:54:37 amd kernel: usb 3-1: USB disconnect, address 2
> > > Oct 22 18:55:33 amd kernel: NETDEV WATCHDOG: bnep0: transmit timed out
> > > Oct 22 18:55:59 amd last message repeated 2 times
> > > Oct 22 18:56:51 amd last message repeated 5 times
> > > Oct 22 18:57:55 amd last message repeated 3 times
> > > Oct 22 18:59:03 amd last message repeated 7 times
> > 
> > The transmit timeouts shouldn't be there. The question is now which side
> > is at fault. The host or the phone?
> 
> This is against second linux box... Can't be the phone.

>From Linux to Linux you can get something around 80KB/sec. Do you have
any other USB dongle to test this against, because I think the PCMCIA
card is the problematic part here.

If you go over RFCOMM to the phone you will almost never reach the full
speed, because most RFCOMM implementation on the phones are not really
good. The PPP is eating the rest of the bandwidth.

Regards

Marcel



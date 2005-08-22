Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVHVVeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVHVVeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVHVVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:34:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751226AbVHVVeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:34:24 -0400
Date: Mon, 22 Aug 2005 14:36:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: solt@dns.toxicfilms.tv
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3com 3c59x stopped working with 2.6.13-rc[56]
Message-Id: <20050822143642.5686ecc8.akpm@osdl.org>
In-Reply-To: <20050822202740.9793.qmail@dns.toxicfilms.tv>
References: <20050822202740.9793.qmail@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

solt@dns.toxicfilms.tv wrote:
>
> i tried to boot 2.6.13-rc5-git4 and 2.6.13-rc6-git13 both with the same
> result: my 3com (3c59x driver on 3com 905c) card not working.
> Here is what I saw in the logs.
> Notice the regularity of the log barfs. They continue the same every 10secs.
> 
> The upgrade was committed using:
> cd /usr/src/linux
> patch -p1 < ../patch-2.6.13-rc5
> patch -p1 < ../patch-2.6.13-rc5-git4
> make oldconfig
> make bzImage modules modules_install install
> 
> gcc-4.0.1 from Debian testing.
> 

I assume it worked OK in 2.6.12.

There are no changes in the driver which would explain this.

> 
> 18:27:47: eth1: Setting full-duplex based on MII #24 link partner capability of 05e1.
> 18:32:02: NETDEV WATCHDOG: eth1: transmit timed out
> 18:32:02: eth1: transmit timed out, tx_status 00 status e601.
> 18:32:02:   diagnostics: net 0cfa media 8880 dma 0000003a fifo 8800
> 18:32:02: eth1: Interrupt posted but not delivered -- IRQ blocked by another device?

gargh, I have acpi feelings.  Could you please

a) Compare /proc/interrupts for 2.6.12 and 2.6.13-rc6

b) Generate the boot-time dmesg output for 2.6.12 and 2.6.13-rc6
   (dmesg -s 1000000 > foo), then do

	diff -u dmesg-2.6.12 dmesg-2.6.13-rc6 > foo

   and send foo?

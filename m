Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVLSXgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVLSXgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 18:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVLSXgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 18:36:00 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:50825 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750717AbVLSXf7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 18:35:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jAbNTJ6v6TcfZoK4UziM/aJvKopWIaDZlIDa1rZXj72BtT3dddAE2VFP10nmWZCtA5d1aOosceR+pg1wQiTwoO+qI9amzLppM3ypbDTQwclmkme28OOrm9rEm0e/58jxjYJIcLIT2v8n5VxniUvSRmSMGQJjtmz4Y9P3xAlLFy8=
Message-ID: <4807377b0512191535i13d00b8chd97872b3e540e2b5@mail.gmail.com>
Date: Mon, 19 Dec 2005 15:35:57 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: c-otto@gmx.de
Subject: Re: Intel e1000 fails after RAM upgrade
Cc: linux-kernel@vger.kernel.org, NetDEV list <netdev@vger.kernel.org>
In-Reply-To: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/05, Carsten Otto <c-otto@gmx.de> wrote:
> Hi there!
>
> First the basic system specs:
> Athlon64 3500+ S939, Winchester
> Kernel 2.6.14.4, X86_64
> 4*1 GB RAM DDR 333, Dual Channel [before: 2*1 GB RAM DDR 400, Dual Channel]
> Intel Gigabit PCI (Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02))
> Abit AV8
>
> After upgrading the memory to 4 GB I noticed my e1000 did not work.
> dmesg shows:
>
> e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   TDH                  <2000>
>   TDT                  <2000>
>   next_to_use          <6>
>   next_to_clean        <0>
> buffer_info[next_to_clean]
>   dma                  <13024c002>
>   time_stamp           <ffffd8c7>
>   next_to_watch        <0>
>   jiffies              <ffffe096>
>   next_to_watch.status <0>

are you using 4096 tx descriptors?  what is your MTU configured to? 
I'm confused because it appears you have 8192 (0x2000) descriptors but
the driver only allows 4096

> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   TDH                  <2000>
>   TDT                  <2000>
>   next_to_use          <6>
>   next_to_clean        <0>
> buffer_info[next_to_clean]
>   dma                  <13024c002>
>   time_stamp           <ffffd8c7>
>   next_to_watch        <0>
>   jiffies              <ffffe28a>
>   next_to_watch.status <0>
> eth0: no IPv6 routers present
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   TDH                  <2000>
>   TDT                  <2000>
>   next_to_use          <6>
>   next_to_clean        <0>
> buffer_info[next_to_clean]
>   dma                  <13024c002>
>   time_stamp           <ffffd8c7>
>   next_to_watch        <0>
>   jiffies              <ffffe47e>
>   next_to_watch.status <0>
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   TDH                  <2000>
>   TDT                  <2000>
>   next_to_use          <6>
>   next_to_clean        <0>
> buffer_info[next_to_clean]
>   dma                  <13024c002>
>   time_stamp           <ffffd8c7>
>   next_to_watch        <0>
>   jiffies              <ffffe672>
>   next_to_watch.status <0>
>
> ethtool -t eth0 offline:
> The test result is FAIL
> The test extra info:
> Register test  (offline)         40
> Eeprom test    (offline)         0
> Interrupt test (offline)         4
> Loopback test  (offline)         13
> Link test   (on/offline)         1
>
> I have two of these cards. Both run fine in my (old, 32bit) server. I
> tested with both cards with both systems. Only in my 64bit machine this
> error occurs - with both cards.
>
> Please tell me what to do. I have to live with the VIA onboard in the
> meantime and that is not the best network card...

well, lets work on what is occuring, because this should work just fine.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSHJRxI>; Sat, 10 Aug 2002 13:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSHJRxI>; Sat, 10 Aug 2002 13:53:08 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:3781 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317107AbSHJRxG>; Sat, 10 Aug 2002 13:53:06 -0400
Date: Sat, 10 Aug 2002 18:55:58 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pawe? Krawczyk <kravietz@aba.krakow.pl>
Cc: zhengchuanbo <zhengcb@netpower.com.cn>,
       "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: about the tuning of eepro100
Message-ID: <20020810185558.C306@kushida.apsleyroad.org>
References: <200208101742654.SM00824@zhengcb> <20020810095126.GF21239@aba.krakow.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020810095126.GF21239@aba.krakow.pl>; from kravietz@aba.krakow.pl on Sat, Aug 10, 2002 at 11:51:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawe? Krawczyk wrote:
> > so i think the limit is at the eepro100 card. is there any way to
> > improve the throughput? or someone got a higher throughput then
> > that?  the eepro100 chip is 82559.
> 
> Use e100 driver from Intel [1] with the following parameters:
> 
> insmod e100.o BundleSmallFr=1 IntDelay=0x600 ucode=1
> 
> Intel's driver supports all the interrupt saving features (interrupt
> delay and small packet bundling) present in EEPro/100 cards. The driver
> is now GPL, so it should get back to the mainstream kernel.

I don't think you will get better than 90% performance, but if you do
please let me know!  I have written another e100 driver, in an attempt
to transmit and receive small packets at the maximum possible rate.

In tests, it would not even transmit at 100% small packets on our 82558.
(I didn't do that test on our 82559).

Ah well..

Curiously, I found that turning on the interrupt saving microcode slows
the cards down.  It lessens the load on the mainboard CPU, but I am not
using interrupts, I'm polling the memory descriptors 100% of the time,
so the interrupt saving microcode shouldn't affect the mainboard CPU.
It does lower the throughput though.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJWAeE>; Tue, 22 Oct 2002 20:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJWAeE>; Tue, 22 Oct 2002 20:34:04 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62189 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262295AbSJWAeD>;
	Tue, 22 Oct 2002 20:34:03 -0400
Date: Tue, 22 Oct 2002 17:39:59 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Slavcho Nikolov <snikolov@okena.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: feature request - why not make netif_rx() a pointer?
Message-ID: <20021023003959.GA23155@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slavcho Nikolov wrote :
> Non GPL modules that want to attach themselves between all L2 drivers and
> upper layers would not have to incur a performance loss if netif_rx() is
> made a
> pointer instead of a function (whether or not NET filters are compiled in
> the kernel).
> Currently control can be easily wrested from netif_rx() and others through
> injection of a few instructions into the running kernel (SMC - self
> modifying code)

	Assuming that every L2 is Ethernet and every L3 is IP ?
	Well, I've got news for you : IrDA drivers are using
netif_rx() to pass IrLAP frames to the IrDA stack, and 802.11 driver
in the future will pass 802.11 frames to the 802.2 LLC layer via
netif_rx().
	Please don't do that, I don't want people breaking the IrDA
stack in weird ways just because some random clueless code hijacked
netif_rx(). Use netfilters, or define your own private protocol/packet
type to do what you want.

	Regards,

	Jean


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWESKXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWESKXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWESKXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:23:49 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:40354 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S932252AbWESKXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:23:49 -0400
Date: Fri, 19 May 2006 13:23:47 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [I2C] question on adapter design
Message-ID: <20060519102347.GM8304@mea-ext.zmailer.org>
References: <20060519084245.19195.qmail@web25807.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060519084245.19195.qmail@web25807.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 08:42:45AM +0000, moreau francis wrote:
> I'm about writing a I2C bus adapter driver and wondering if it worth
> to use interrupt for transfering data on the bus or just polling is
> good enough ?
> 
> My hardware has a 8 bytes fifo for both Tx/Rx. It can generates
> an interrupt when Tx fifo is empty and Rx fifo is not empty, 
> actually like any UARTs. My CPU speed is 96 Mhz.

The I²C (TM Philips) -bus runs at 100 kHz or (high-speed one) at 400 kHz.
An eight bit byte goes thru it in 80 or 20 microseconds depending on used
speed.  If your interrupt processing considers it as medium level
priority and fills the Tx fifo with as much as is available (most I²C TX
sequences do fit inside the 8 byte fifo) and collects as much data as is
available in the Rx fifo, you should be well set.

Most notable detail there is, that you do have those (for I²C) huge FIFOs.
Another thing is (I haven't verified this) that I²C master controls the
bus clock, and can stop it temporarily, when Tx FIFO is empty, or Rx FIFO
is full.

> Thanks for your advices
> Francis

/Matti Aarnio

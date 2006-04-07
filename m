Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWDGIzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWDGIzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWDGIzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:55:31 -0400
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:4805 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932391AbWDGIzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:55:31 -0400
Message-ID: <443628F3.9050107@drzeus.cx>
Date: Fri, 07 Apr 2006 10:55:15 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ram <vshrirama@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDIO Drivers?
References: <8bf247760604040130n155eeffauc5798750f8357bca@mail.gmail.com>
In-Reply-To: <8bf247760604040130n155eeffauc5798750f8357bca@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> Hi,
>    i want to write an SDIO driver. There is not much information of
> what an SDIO driver is
>    supposed to do or any sample sdio drivers.
> 
>    I have a few questions regarding that:
> 
>    1) What is an SDIO Driver?.
> 

They don't exist in the kernel right now, that's why you haven't found
any examples.

To support SDIO, the MMC layer would need to be extended to handle the
initialisation of SDIO cards (they're a bit different from SD storage
and MMC). After that, a driver model needs to be constructed. It might
be possible to build upon the current MMC driver model, but one would
need to make sure that cards that are both storage and SDIO are handled.

>    2) Is SDIO a protocol/standard to which all devices confirm?.
> 

It's a subset of the SD standard suite. Note that it only specifies how
to get access to registers in the card (like for instance PCI). To
actually use the card you also need a specification for how to use the
registers.

>    3)  Is it a generic driver ?. (Same for a set of devices) or
> different for each device?
>         Suppose i want to run an SDIO WLAN Card?. will the
> manufacturer support it or
>        an will a Generic Driver "drive" it?
> 

Depends on if there is a generic interface for SDIO WLAN cards. SD is a
very closed world so we know very little about the protocols.

>    4) What is a SD Driver?
> 

Depends on context. It might refer to the driver for SD storage cards.
Or it might refer to a driver for the SD controller (that interfaces to
the card(s)).

>    5) What are the differences between SD Driver and SDIO Driver?.
> 

If we're talking about SD storage vs SDIO, then the drivers use
different parts of the SD protocol. They share the same bus interface
though (which is implemented as the MMC layer in Linux).

> 
>    6) Are there any sample/Open Source SDIO drivers available in Linux
> Kernel or else where?.If, not when can one expect/is anyone working on
> it currently?.
> 

There are a lot of people interested, but I haven't seen anyone working
on it yet.

Rgds
Pierre


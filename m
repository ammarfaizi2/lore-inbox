Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRJQQEG>; Wed, 17 Oct 2001 12:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276737AbRJQQD4>; Wed, 17 Oct 2001 12:03:56 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:40163 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276708AbRJQQDl>; Wed, 17 Oct 2001 12:03:41 -0400
Message-ID: <3BCDAC10.A7F40982@t-online.de>
Date: Wed, 17 Oct 2001 18:04:32 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Steven A. DuChene" <sduchene@mindspring.com>
CC: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
In-Reply-To: <1003288485.14282.100.camel@thanatos> <20011017041014.B2015@lapsony.mydomain.here>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven A. DuChene" wrote:
> 
> OK, I tried this with the Intel STL2 motherboard I also have and I got
> a similar error when trying to load the correct i2c bus module when the
> PnPBIOS stuff is compiled into the kernel.
> 
> modprobe i2c-piix4
> /lib/modules/2.4.10-ac12pnp/kernel/drivers/i2c/i2c-piix4.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ >parameters

i2c-piix4 has to be taught to ignore PNP0c0x reservations.

PNP0C02 means "mainboard resource" and obviously i2c-piix4
would like to use it, so it should make use of it's knowledge.

As "mainboard resouce" is very generic we must reserve it
to protect against mapping other addresses over it.

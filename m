Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965271AbVLRUCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbVLRUCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVLRUCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:02:50 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:4798 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965271AbVLRUCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:02:50 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git 3/3] SPI core refresh: SPI/PNX bus driver and EEPROM driver
Date: Sun, 18 Dec 2005 12:02:48 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
References: <20051215125800.4fa95de6.vwool@ru.mvista.com> <20051215130205.2ebdea18.vwool@ru.mvista.com> <20051215130354.5ca3d99f.vwool@ru.mvista.com>
In-Reply-To: <20051215130354.5ca3d99f.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181202.48218.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null
> +++ linux-2.6.orig/drivers/spi/pnx4008-eeprom.c
> @@ -0,0 +1,121 @@
> ...
> +#define EEPROM_SIZE		256
> +#define DRIVER_NAME		"EEPROM"
> +#define READ_BUFF_SIZE 160

Wouldn't it be better to have an EEPROM driver that's not hard-wired
to this particular devel board?  And which could work on at least all
chips using eight bit addressing?

This seems to match the 25020 series SPI EEPROMS.  (2 Kbits, 256 bytes.)
But the 25010 and 25040 also use 8 bit address protoocol ... and then
there are also chips using 16 bit addresses, and 24 bit ones.

Shouldn't board init code be able to just say "25640 at spi1 chipselect 3",
and have the driver know that means 8 KBytes with pagesize 32?

- Dave


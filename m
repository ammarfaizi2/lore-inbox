Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTLLPnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbTLLPnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:43:55 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38611 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265263AbTLLPnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:43:53 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Daniel Tram Lux <daniel@starbattle.com>
Subject: Re: [patch] ide.c as a module
Date: Fri, 12 Dec 2003 16:46:04 +0100
User-Agent: KMail/1.5.4
References: <20031211202536.GA10529@starbattle.com> <200312121430.36735.bzolnier@elka.pw.edu.pl> <20031212144246.GA15357@starbattle.com>
In-Reply-To: <20031212144246.GA15357@starbattle.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121646.04047.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 of December 2003 15:42, Daniel Tram Lux wrote:
> Hi,
>
> I tried with using only your suggested changes and removing the ide_probe
                            ^^^^
Your patch + changes or only changes?

> ptr, but due to (in include/asm-i386/ide.h) where CONFIG_BLK_DEV_IDEPCI is
> indeed undefined:
>
> static __inline__ void ide_init_default_hwifs(void)
> {
> #ifndef CONFIG_BLK_DEV_IDEPCI
> 	hw_regs_t hw;
> 	int index;
>
> 	for(index = 0; index < MAX_HWIFS; index++) {
> 		memset(&hw, 0, sizeof hw);
> 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
> 		hw.irq = ide_default_irq(ide_default_io_base(index));
> 		ide_register_hw(&hw, NULL);
> 	}
> #endif /* CONFIG_BLK_DEV_IDEPCI */
> }
>
> I get the following probing messages (I enabled a debug message which is
> why there are so many messages):

"initializing = 1" must be moved from ide_init() to ide_init_data()
(just before ide_init_default_hwifs() call).

--bart


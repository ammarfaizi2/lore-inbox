Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270636AbTG0ABz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 20:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270637AbTG0ABz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 20:01:55 -0400
Received: from lidskialf.net ([62.3.233.115]:61121 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270636AbTG0ABz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 20:01:55 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Subject: Re: 2.6.0-test1: irq18 nobody cared! on Intel D865PERL motherboard -- found it!
Date: Sun, 27 Jul 2003 01:17:06 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030714131240.21759.qmail@linuxmail.org> <1059260505.1119.6.camel@hades> <200307270023.43992.adq_dvb@lidskialf.net>
In-Reply-To: <200307270023.43992.adq_dvb@lidskialf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270117.06786.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is something else that is not being done by linux. I'd assumed this
> was an nforce2-specific issue, but your results hint that it may be larger
> than this.

Yay! I've found it. What seems to be happening is the PIC is left connected to 
the PCI IRQ lines, and is causing problems.. I assume pulling the lines 
up/down incorrectly.

My BIOS lets me define which PIC IRQs are allocated to PCI and which are 
"reserved". I set them all to reserved, effectively disabling any IRQs < 15 
being allocated to PCI. Now everything works perfectly. 

I've downloaded the manual for your motherboard, but I can't see anything like 
that for your board.. all you can do is the standard choose IRQ, or auto.

Anyway, now I know what is causing this, expect a patch soon.


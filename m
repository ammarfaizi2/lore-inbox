Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSGYNgh>; Thu, 25 Jul 2002 09:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSGYNf1>; Thu, 25 Jul 2002 09:35:27 -0400
Received: from [217.167.51.129] ([217.167.51.129]:45022 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S314596AbSGYNfK>;
	Thu, 25 Jul 2002 09:35:10 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, <martin@dalecki.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
Date: Thu, 25 Jul 2002 15:39:18 +0200
Message-Id: <20020725133918.37@192.168.4.1>
In-Reply-To: <1027602528.9488.68.camel@irongate.swansea.linux.org.uk>
References: <1027602528.9488.68.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Martin this patch should do the job. It uses the correct pci_config_lock
>and it also adds the 2.4 probe safety checks for deciding which pci
>modes to use.

Hrm... pci_config_lock is specific to arch/i386 it seems (and is even
a static in 2.4.19rc3). That is no good as this isn't the only
driver to do config access from interrupts, so at least PPC is
broken in this regard.

Wouldn't it make sense to generalize it and implement it on all archs ?

(That is move extern declaration of it to linux/pci.h, definition to
drivers/pci/pci.c, and so on...)

I'd rather have a per-host lock, but on the other hand, the host bus
mecanism is still quite arch-specific, thus making difficult to use
a per-host lock in drivers, at least in 2.4


Ben.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290513AbSAYTm0>; Fri, 25 Jan 2002 14:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290625AbSAYTmN>; Fri, 25 Jan 2002 14:42:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:62973 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S290513AbSAYTmC>; Fri, 25 Jan 2002 14:42:02 -0500
Date: Fri, 25 Jan 2002 11:39:10 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: OOPS in 2.5.3-pre5 -- kernel BUG at slab.c:1101!
To: Miles Lane <miles@megapathdsl.net>, Ingo Molnar <mingo@elte.hu>,
        Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-id: <03aa01c1a5d8$1d4d2ac0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <1011939163.1540.18.camel@stomata.megapathdsl.net>
 <1011986299.1370.77.camel@stomata.megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David and Greg, I think this OOPS may be related to the
> new EHCI/ohci-hcd code.  This machine has an early NEC
> USB 2.0 host controller and an USB OHCI host controller:

Configure with CONFIG_DEBUG_SLAB and it should go
away.  Or, tweak drivers/usb/hcd/ohci-mem.c line 45 to
be #ifdef CONFIG_DEBUG_SLAB.  A patch is pending,
but it's included with some other updates to that code
and I wanted to re-test.

Or a more fundamental fix would be to remove those
#ifdefs from the EHCI and OHCI HCD code and just
change drivers/pci/pci.c at about line 1065 to poison
based on CONFIG_DEBUG_SLAB rather than using
CONFIG_PCIPOOL_DEBUG ... that #ifdef predates
CONFIG_DEBUG_SLAB.

- Dave



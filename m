Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTEPRmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTEPRmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:42:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37287
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264514AbTEPRmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:42:49 -0400
Subject: Re: [RFC][ide] simplification of probing for default interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305152134420.21794-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305152134420.21794-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053104232.5590.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 17:57:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-15 at 20:37, Bartlomiej Zolnierkiewicz wrote:
> ide_init_default_hwifs() does exactly what init_hwif_data() already does
> (both for compiled-in and module case) with exception that it also sets
> hwif->irq, but this is really not a problem since if irq autodection fails,
> driver will fallback to using arch specific default irq.

That sounds sensible, and the iops and other junk

> What I propose is to kill ide_init_default_hwifs() and rely on irq
> autodection + fallback code in ide-probe.c. This requires splitting

Remember the IRQ depends on the mode of the device (legacy v PCI native)
plus some chip specific constraints on pairing.

> ide_init_default_hwifs() to ide_default_io_base() and ide_default_irq()
> for some arm subarchs and breaking (or making it special case)

PA RISC also requires it can override default irq, and wants to know if
the device is the primary or secondary. 



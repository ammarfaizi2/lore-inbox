Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263846AbRFDREw>; Mon, 4 Jun 2001 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbRFDPUC>; Mon, 4 Jun 2001 11:20:02 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6579 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264313AbRFDPTz>; Mon, 4 Jun 2001 11:19:55 -0400
Date: Mon, 4 Jun 2001 15:17:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Feng Xian <fxian@fxian.jukie.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
In-Reply-To: <Pine.LNX.4.33.0106021357110.5655-100000@tiger>
Message-ID: <Pine.GSO.3.96.1010604150030.26759B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, Feng Xian wrote:

> I forget to mention. in the same hardware configuration (same slot, sharing
> IRQ with other card) my card works perfect if I was using uni-processor
> without APIC support kernel (i tried 2.4.5-ac6 with apic disabled
> uniprocessor on a dual p3 box). If the driver did something wrong, it
> should not work on that system either. Maybe what I thought was wrong.

 There is a small difference in interrupt delivery between i8259A and I/O
APIC configurations.  An I/O APIC incurs a slightly larger delivery
latency, both for asserts and for deasserts.  You need to be prepared for
it in the driver, especially for the latter case, i.e. send an IRQ ack
early to the device, so there is enough time for a message to go through
the inter-APIC bus.  Otherwise you risk spurious interrupts. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


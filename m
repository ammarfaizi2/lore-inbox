Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTISKQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbTISKQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:16:08 -0400
Received: from svr7.m-online.net ([62.245.150.229]:59049 "EHLO
	svr7.m-online.net") by vger.kernel.org with ESMTP id S261486AbTISKQD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:16:03 -0400
Date: Fri, 19 Sep 2003 12:14:24 +0200
From: Klaus Kurzmann <mok@fluxnetz.de>
To: Valdis.Kletnieks@vt.edu
Cc: Russell King <rmk@arm.linux.org.uk>, Sean Estabrooks <seanlkml@rogers.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA] Xircom nic hang on boot since cs.c race condition patch
Message-ID: <20030919101424.GB1186@fluxnetz.de>
References: <20030917144406.753953dd.seanlkml@rogers.com> <20030917223336.H16045@flint.arm.linux.org.uk> <200309190247.h8J2lmhx005690@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200309190247.h8J2lmhx005690@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.0-gpgme-030408
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu schrieb am Donnerstag, den 18.09.2003 um 22:47:
> Is it the fact that it's a multi-function card?

> lspci -v says:
> 03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
>         Subsystem: Xircom Cardbus Ethernet 10/100
>         Flags: bus master, medium devsel, latency 64, IRQ 9
>         I/O ports at 1000 [size=128]
>         Memory at 10800000 (32-bit, non-prefetchable) [size=2K]
>         Memory at 10800800 (32-bit, non-prefetchable) [size=2K]
>         Expansion ROM at 10400000 [disabled] [size=16K]
>         Capabilities: [dc] Power Management version 1

> 03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
>         Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
>         Flags: medium devsel, IRQ 9
>         I/O ports at 1080 [size=8]
>         Memory at 10801000 (32-bit, non-prefetchable) [size=2K]
>         Memory at 10801800 (32-bit, non-prefetchable) [size=2K]
>         Expansion ROM at 10404000 [disabled] [size=16K]
>         Capabilities: [dc] Power Management version 1

> I could see problems if the serial controller is being added while the ethernet
> controller is still getting its act together while holding locks, since it's one
> physical card.

I have the same problem with my 3Com card, which is ethernet only.

02:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
        Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1800 [size=256]
        Memory at 10800000 (32-bit, non-prefetchable) [size=128]
        Memory at 10800080 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 10400000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2





-- 
Klaus Kurzmann, FluxNetz GmbH
Tel: +49 (0)89 140 79 281                  eMail: mok@fluxnetz.de
Fax: +49 (0)89 140 79 282                  www  : http://www.fluxnetz.de

Bitte senden Sie mir keine Word- oder PowerPoint-Anhänge.
Siehe http://www.fsf.org/philosophy/no-word-attachments.de.html

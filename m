Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbSLKQoH>; Wed, 11 Dec 2002 11:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbSLKQoH>; Wed, 11 Dec 2002 11:44:07 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:63682
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267209AbSLKQoG>; Wed, 11 Dec 2002 11:44:06 -0500
Subject: Re: Linux 2.4.21-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: lkml <linux-kernel@vger.kernel.org>, andre@linux-ide.org
In-Reply-To: <20021211155650.GU8741@charite.de>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
	<20021211090829.GD8741@charite.de>
	<1039622867.17709.31.camel@irongate.swansea.linux.org.uk>
	<20021211153414.GQ8741@charite.de>  <20021211155650.GU8741@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 17:29:00 +0000
Message-Id: <1039627740.17709.82.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok this seems to be the problem

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if
8a [Master SecP PriP])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at cff8 [size=8]
        Region 1: I/O ports at cff4 [size=4]
        Region 2: I/O ports at cfe8 [size=8]
        Region 3: I/O ports at cfe4 [size=4]


The hardware isnt at the normal ide base addresse, yet the chip is
reporting that it isnt in native mode. As far as I can see this
configuration isnt allowed.

We see that the chip isnt in native mode so we defer to the legacy
scanner. Since the ports are not valid the legacy scanner doesn't find
them.

Any thoughts on how we should handle this case Andre ?



Alan


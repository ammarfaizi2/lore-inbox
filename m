Return-Path: <linux-kernel-owner+w=401wt.eu-S1752676AbWLOOqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbWLOOqc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbWLOOqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:46:31 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:57474 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbWLOOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:46:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=oRscP5ylEYMXfmuC5RIJrY8rcrasXQ+EAWvNR9+FZqJkTIpRiGoaagLLuI62zTaM1u9Q+o3SgBoAdD17o1iQxwqDdr0y9YsAdOEYpzcTtz3seuNcaQuuumPWdBgci0XAmwVyWKX0/imVysR4/iIlsUiQJhtiUwuonIg+tKwEExc=
Message-ID: <4582B53A.8010809@gmail.com>
Date: Fri, 15 Dec 2006 15:45:55 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>
Subject: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
References: <20061214225913.3338f677.akpm@osdl.org>
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Temporarily at
> 
> 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
> 
> Will appear later at
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/

The kernel panics at boot in pdc_port_start+0x82 with deref of 0x14:
http://www.fi.muni.cz/~xslaby/sklad/pdc_oops.png

ATA port is not connected, only 2 SATA disks on my
# lspci -vvxs 02:01.0
02:01.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300
TX2plus) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 8000 [size=128]
        Region 2: I/O ports at 8400 [size=256]
        Region 3: Memory at fb025000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
        [virtual] Expansion ROM at 50000000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 73 3d 07 00 30 02 02 00 80 01 01 48 00 00
10: 01 80 00 00 00 00 00 00 01 84 00 00 00 50 02 fb
20: 00 00 00 fb 00 00 00 00 00 00 00 00 5a 10 73 3d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 04 12

2.6.19-rc6-mm2 is OK (2.6.19-mm1 untested and won't be)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

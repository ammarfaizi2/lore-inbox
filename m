Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbREBHK1>; Wed, 2 May 2001 03:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135980AbREBHKS>; Wed, 2 May 2001 03:10:18 -0400
Received: from post2.inre.asu.edu ([129.219.110.73]:57477 "EHLO
	post2.inre.asu.edu") by vger.kernel.org with ESMTP
	id <S129282AbREBHKN>; Wed, 2 May 2001 03:10:13 -0400
Date: Wed, 02 May 2001 00:09:58 -0700
From: Russ Dill <Russ.Dill@asu.edu>
Subject: Re: Breakage of opl3sax cards since 2.4.3 (at least)
To: dbronaugh@opensourcedot.com, linux-kernel@vger.kernel.org
Message-id: <3AEFB2C6.24F7B40D@asu.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac1-lpp i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, this occured at 2.4.2

I searched though the archives, and the only people who were able to get
this resolved were those with a non-isapnp card (by added isapnp=0).
However, I have an isapnp card and the driver doesn't think my card
exists. If I lod it, withot options, I get:

russ kernel: opl3sa2: ISA PnP activate failed
russ kernel: opl3sa2: No PnP cards found
russ kernel: opl3sa2: 0 PnP card(s) found.

OK, so I use my old isapnp.conf 

russ:/home/russ# isapnp /etc/isapnp.conf

then insmod it like this:
Board 1 has Identity 81 ff ff ff ff 20 00 a8 65:  YMH0020 Serial No -1
[checksum 81]
YMH0020/-1[0]{OPL3-SAX Sound Board}: Ports 0x240 0xE80 0x388 0x300
0x100; IRQ10 DMA0 DMA3 --- Enabled OK
YMH0020/-1[1]{OPL3-SAX Sound Board}: Port 0x204; --- Enabled OK

russ:/home/russ# insmod opl3sa2 irq=10 io=0x240 dma=0 dma2=3
mss_io=0xe80 isapnp=0
Using /lib/modules/2.4.4-ac1-lpp/kernel/drivers/sound/opl3sa2.o
/lib/modules/2.4.4-ac1-lpp/kernel/drivers/sound/opl3sa2.o: init_module:
No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters


hmm, and kern.log says:

russ kernel: opl3sa2: Control I/O port 0x240 is not a YMF7xx chipset!

something in the changeover forgot about my card

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290865AbSARXKj>; Fri, 18 Jan 2002 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290869AbSARXKa>; Fri, 18 Jan 2002 18:10:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33803 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290865AbSARXKV>; Fri, 18 Jan 2002 18:10:21 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: yoder1@us.ibm.com (Kent E Yoder)
Date: Fri, 18 Jan 2002 23:19:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <OF0DC8C676.D07D3CD8-ON85256B45.007E1B7C@raleigh.ibm.com> from "Kent E Yoder" at Jan 18, 2002 05:02:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RiHs-0008CD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   BTW, I don't know what PCI posting effects are...

Ok given

	writel(foo, dev->reg);
	udelay(5);
	writel(bar, dev->reg);

The pci bridge is at liberty to delay the first write until the second or a
read from that device comes along (and wants to do so to merge bursts). It
tends to bite people

	-	When they do a write to clear the IRQ status and don't do
		a read so they keep handling lots of phantom level triggered
		interrupts.

	-	When there is a delay (reset is common) that has to be observed

	-	At the end of a DMA transfer when people unmap stuff early
		and the "stop the DMA" command got delayed

Alan

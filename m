Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281565AbRKMJn6>; Tue, 13 Nov 2001 04:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281566AbRKMJns>; Tue, 13 Nov 2001 04:43:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281565AbRKMJnl>; Tue, 13 Nov 2001 04:43:41 -0500
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
To: adam-dated-1006069566.ee3370@flounder.net (Adam McKenna)
Date: Tue, 13 Nov 2001 09:51:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011112234604.C29675@flounder.net> from "Adam McKenna" at Nov 12, 2001 11:46:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163aDx-0000aQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I ask because I'm still having major problems with the OSB4 chipset on
> 2.4.14.  I've had to disable DMA completely on my boxes to avoid IDE errors
> and fs corruption.  Does anyone know of a patch that addresses the issues
> with this chipset?

No. I spent some time digging into this problem with both Serverworks and
Red Hat customers. With certain disks, certain OSB4 revisions and UDMA 
the controller occasionally gets "stuck", the next DMA it issues starts
by reissuing the last 4 bytes of the previous request and the entire thing
goes totally to crap.

The -ac tree will detect this case and panic and hang the machine solid to
avoid actual disk corruption. The real fix appears to be "dont do UDMA on
the OSB4". The CSB5 seems fine.

Alan

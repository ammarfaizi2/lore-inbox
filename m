Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVKWLQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVKWLQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKWLQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:16:48 -0500
Received: from d213-102-147-102.cust.tele2.pl ([213.102.147.102]:18048 "EHLO
	iglo.domek.prywatny") by vger.kernel.org with ESMTP
	id S1030398AbVKWLQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:16:47 -0500
Date: Wed, 23 Nov 2005 12:11:27 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Horms <horms@verge.net.au>, Karol Lewandowski <klz@o2.pl>,
       340228@bugs.debian.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH, IDE] Blacklist CD-912E/ATK
Message-ID: <20051123111127.GA1823@iglo.domek.prywatny>
References: <20051122024426.8C16A34043@koto.vergenet.net> <1132691179.20233.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132691179.20233.77.camel@localhost.localdomain>
X-Alternate-Email: klz at o2.pl
X-Avoid-Like-Plague: Sony, RIAA
User-Agent: Mutt/1.5.9i
From: kl@jasmine.eu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 08:26:19 +0000, Alan Cox wrote:
 
> >     The drive is clearly broken.  Adding blacklist to drivers/ide/ide-dma.c
> >     for this model ("CD-912E/ATK") fixes this problem.
 
> That may be the case but knowing if th drive is the problem is more
> tricky.

By saying that drive is broken I meant "it never worked with DMA", at
least for me.  Sorry for not being clear.

I have more to add -- IMHO blacklisting the drive doesn't fix the
problem, but just works around it.  As I written in my original bug
report[1] I thought panic shouldn't happen anyway.  I also noted that
kernels 2.4.* handle this situation gracefully, and pointed out that
the time between panic (in 2.6), and graceful recovery (in 2.4)
differs between kernels.

[1] http://bugs.debian.org/340228

 
> Firstly try it on a different controller

I tested it on two controllers:
0000:00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)

Kernel panics as before on both of them.


> Secondly check for other firmware revisions 
> Thirdly blacklist only your firmware rev if there are others

Here goes output of "hdparm -i" for said drive.

 Model=CD-912E/ATK, FwRev=17A, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:209,w/IORDY:180}, tDMA={min:150,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 *mdma1 
 AdvancedPM=no

As things are more clear now, I think there is no reason to search for
newer firmware for this drive?  (This is Generic-IDE bug, right?)


> >     hdc: DMA disabled
> >     ------------[ cut here ]------------
> >     kernel BUG at drivers/ide/ide-iops.c:949!
> >     invalid operand: 0000 [#1]
 
> That is an IDE layer bug not a drive incompatibility. It may be one
> triggered the other but until the BUG the kernel was correctly behaving
> and had just turned off DMA anyway.

This is what I thought in the first place, and this is what I
suggested in my original bug report.  Debian kernel mainainer shortened
the report somewhat, probably because it was too long and too boring.
Additionaly I incorrectly stated that blacklisting _fixes_ the
problem, which was even not what I personally thought. ;)

Sorry for that.

-- 
This signature intentionally says nothing.

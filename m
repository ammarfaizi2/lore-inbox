Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318399AbSGYJKn>; Thu, 25 Jul 2002 05:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318401AbSGYJKn>; Thu, 25 Jul 2002 05:10:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:14586 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318399AbSGYJKm>; Thu, 25 Jul 2002 05:10:42 -0400
Subject: Re: Safety of IRQ during i/o
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pete Zaitcev <zaitcev@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D3FAEB1.6070704@evision.ag>
References: <Pine.SOL.4.30.0207250041400.15959-100000@mion.elka.pw.edu.pl> 
	<3D3FAEB1.6070704@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:26:24 +0100
Message-Id: <1027592784.9489.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 08:54, Marcin Dalecki wrote:
> > Yup, for PIO unmask (if possible) is a must.
> 
> It's even for DMA a good thing, since the IRQ handler in question can
> reenter the RQ handler. The invention of the not unmasking
> behaviour in Linux is the result of some not entierly ATA-2 compliant
> devices long long time ago gone. Basically XT disks on PC. They did have 
> the habbit of splewing IRQs too early for command ACK.

There are also some older systems where if the block transfer of the IDE
data didn't keep up with the controller instead of handshaking properly
it kind of dribbled random numbers onto the disk.

Unless anyone knows of PCI era devices with this problem I would be
inclined to agree that we should default to IRQ unmasking in the 2.5 IDE
code if the IDE controller is PCI.

For old ISA/VLB controllers its safer left as is, and nobody running a
machine like that can realistically expect good performance without hand
tuning stuff anyway


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318379AbSGYJnB>; Thu, 25 Jul 2002 05:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318381AbSGYJnB>; Thu, 25 Jul 2002 05:43:01 -0400
Received: from zeus.kernel.org ([204.152.189.113]:52386 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318379AbSGYJnA>;
	Thu, 25 Jul 2002 05:43:00 -0400
Message-ID: <3D3FC625.1020202@evision.ag>
Date: Thu, 25 Jul 2002 11:34:29 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pete Zaitcev <zaitcev@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Safety of IRQ during i/o
References: <Pine.SOL.4.30.0207250041400.15959-100000@mion.elka.pw.edu.pl> 	<3D3FAEB1.6070704@evision.ag> <1027592784.9489.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-07-25 at 08:54, Marcin Dalecki wrote:
> 
>>>Yup, for PIO unmask (if possible) is a must.
>>
>>It's even for DMA a good thing, since the IRQ handler in question can
>>reenter the RQ handler. The invention of the not unmasking
>>behaviour in Linux is the result of some not entierly ATA-2 compliant
>>devices long long time ago gone. Basically XT disks on PC. They did have 
>>the habbit of splewing IRQs too early for command ACK.
> 
> 
> There are also some older systems where if the block transfer of the IDE
> data didn't keep up with the controller instead of handshaking properly
> it kind of dribbled random numbers onto the disk.
 >
> Unless anyone knows of PCI era devices with this problem I would be
> inclined to agree that we should default to IRQ unmasking in the 2.5 IDE
> code if the IDE controller is PCI.

Tough not 100% but I'm about 99% sure that having this kind of problem
no PCI bus would prevent any kind of proper level triggered IRQ handling 
  on behalf of the host controller... At least it seems very very 
unlikely. (Data transfer problems are a different story of course.)
And I personally never ever expirenced *any* problems with -u1 on any 
Linux systems I ever got in to my hands (startting 386sx 16MHz...).
Not even at the time I run the really buggy CMD640 mask revision for 3
years.

> For old ISA/VLB controllers its safer left as is, and nobody running a
> machine like that can realistically expect good performance without hand
> tuning stuff anyway

Sounds fairly well and is easy to implement...just adding

if (ch->pci_dev != NULL && ch->umask)

at the corresponding plase in ata_irq_request will do the trick.


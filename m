Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290888AbSASAgT>; Fri, 18 Jan 2002 19:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290889AbSASAgJ>; Fri, 18 Jan 2002 19:36:09 -0500
Received: from c007-h014.c007.snv.cp.net ([209.228.33.221]:50393 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S290888AbSASAfz>;
	Fri, 18 Jan 2002 19:35:55 -0500
X-Sent: 19 Jan 2002 00:35:48 GMT
Message-ID: <3C48BF64.FBF58C7C@bigfoot.com>
Date: Fri, 18 Jan 2002 16:35:48 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133 & HPT 370 IDE disk corruption
In-Reply-To: <00c201c1a033$1cf46700$b71c64c2@viasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Forssell wrote:
> 
> We first reported disk corruption with a VIA KT133A based board (Abit KT7A)
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100651892331843&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100669782329815&w=2
>
> ...
> It turned out that the main culprit was the NIC that was attached to PCI
> slot
> 4. Moving it to slot 3 resolved the disk corruption as well as the oopses
> that
> occured. Other PCI slots to avoid for the NIC were 5 and 6. Slot 4 & 6
> shares
> an IRQ with the VIA USB controller, but I did try disabling it from the BIOS
> but it didn't help (lspci didn't show the device after it had been
> disabled).
> Slot 5 shares and IRQ with the Highpoint controller.
> 
> Finally, we tested that it works with an  Adaptec 2940UW SCSI card in PCI
> slot
> 1 and the NIC in PCI slot 3.
> 
> More details on request. Does anyone have any idea what causes this?

My BP6's [hpt366] had similar sustained I/O lockup issues, especially
when running a RAID stripe.  From the v1.01 BP6 manual:
...
PCI slots 4 and 5 use the same bus master control signal.

PCI slot 3 shares IRQ signals with the HPT366 IDE controller
(Ultra ATA/66).  The driver for the HPT 366 IDE controller
supports IRQ sharing with other PCI devices. But if you
install a PCI card that doesn t allow IRQ sharing with other
devices into PCI slot 3, you may encounter some problems.
Furthermore, if your Operating System doesn t allow peripheral
devices to share IRQ signals with each other--Windows NT for
example, you can t install a PCI card into PCI slot 3.
...

Of course, I didn't read this until much later.

rgds,
tim.
--

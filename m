Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVGKUQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVGKUQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVGKUNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:13:52 -0400
Received: from totor.bouissou.net ([82.67.27.165]:53142 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262559AbVGKUNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:13:17 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 22:13:14 +0200
User-Agent: KMail/1.7.2
Cc: "Alan Stern" <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C49@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C49@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112213.14842@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 21:52, Protasevich, Natalie a écrit :
>
> Michel, it would be interesting to see if you have problems with the kernel
> that doesn't have the fix posted in that bugzilla yet, but only has my
> first patch.

Do you mean the patch 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c434b7a6aedfe428ad17cd61b21b125a7b7a29ce
alone ?

I'll try to compile a kernel this way tomorrow, it's a bit late tonight...

Furthermore, please tell me if there are risks that I seriously break let's 
say my IDE devices interrupts doing this?
I use EVMS software RAID-5, and I don't want any problem with my RAID-5 set 
(I'm just out of some that took me hours...) especially because the EVMS 
snapshots I use for performing backups don't work anymore (I mean: are 
horribly broke) since I upgraded to a 2.6 series kernel.

This is quite another file, but just to explain that I don't have any recent 
and reliable backup these days, not time for me to take any unnecessary risk 
with my RAID-5 set until this gets fixed...

> Thank you Alan! You helped me too, since my patch has broken a couple VIA
> chips lately. Now I know that at least the fix works...

Well, that's what I'm worried about ;-))

Anyway, here are the differences I already noticed with and without your two 
patches, regarding the way the interrupts are distributed:

1/ Without your patches	(from an old note I took) :

[root@totor etc]# cat /proc/interrupts
           CPU0
  0:     626375    IO-APIC-edge  timer
  1:       1599    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       1708    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
 14:      19858    IO-APIC-edge  ide2
 15:       5220    IO-APIC-edge  ide3
 16:      30711   IO-APIC-level  nvidia
 18:       1799   IO-APIC-level  eth0, eth1
 19:     103365   IO-APIC-level  ide0, ide1, ehci_hcd:usb4, aic7xxx
 21:      47273   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 22:       2782   IO-APIC-level  VIA8233

(I've removed an SCSI controller and added another 2-channel IDE controller 
between the 2 outputs)

2/ With your 2 patches :

> > [root@totor etc]# cat /proc/interrupts
> >            CPU0
> >   0:     934501    IO-APIC-edge  timer
> >   1:       4611    IO-APIC-edge  i8042
> >   2:          0          XT-PIC  cascade
> >   4:       2779    IO-APIC-edge  serial
> >   7:          3    IO-APIC-edge  parport0
> >  14:       7909    IO-APIC-edge  ide4
> >  15:       7918    IO-APIC-edge  ide5
> >  16:      38447   IO-APIC-level  nvidia
> >  18:       2982   IO-APIC-level  eth0, eth1
> >  19:      37041   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
> >  21:      52036   IO-APIC-level  uhci_hcd:usb1,
> > uhci_hcd:usb2, uhci_hcd:usb3
> >  22:       2850   IO-APIC-level  VIA8233
> > NMI:          0
> > LOC:     934453
> > ERR:          0
> > MIS:          0

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E

La Marseillaise sera d'autant moins sifflée qu'elle sera entonnée par tous.
	-- Raffoirius, Premier Ministre

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318089AbSGMEBy>; Sat, 13 Jul 2002 00:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318090AbSGMEBx>; Sat, 13 Jul 2002 00:01:53 -0400
Received: from ausadmmsrr504.us.dell.com ([143.166.83.91]:27666 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318089AbSGMEBw>; Sat, 13 Jul 2002 00:01:52 -0400
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: alan@lxorguk.ukuu.org.uk, greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: RE: Removal of pci_find_* in 2.5
Date: Fri, 12 Jul 2002 23:04:36 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1131795F1473338-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have several examples where the ordering of the PCI cards 
> is critical
> to get stuff like boot device and primary controller detection right.
> pci_register_driver doesn't appear to have a good way to deal 
> with this or have I missed something ?

Indeed, this is used for a variety of reasons:

1) Systems with both on-motherboard and add-in disk controllers which share
a driver, where you really need the on-motherboard controller to appear
first before any add-in cards.  aacraid driver in 2.4.x does this today.
2) Systems with both an older and newer add-in card which share a driver,
where the older (original) card has your boot disks, and any newer card
would get added for adding more storage later.  megaraid driver in
2.4.x/2.5.x does this today.

In both these cases, the pci_find_device() functions use an explict ordering
to make it far more likely we can still boot the system after adding new
hardware.  Unless/until there's a method for telling the kernel/modules that
a particular device is the boot device (ala BIOS EDD 3.0 if vendors were to
get around to implementing such) explict ordering in the drivers is the only
way we can build complex storage solutions and boot reliably.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)


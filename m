Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRBSXA4>; Mon, 19 Feb 2001 18:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBSXAq>; Mon, 19 Feb 2001 18:00:46 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:11795 "HELO
	cicero2.cybercity.dk") by vger.kernel.org with SMTP
	id <S129185AbRBSXAm>; Mon, 19 Feb 2001 18:00:42 -0500
Message-Id: <200102192300.AAA83822@usr00.cybercity.no>
Subject: Re: PROBLEM: pci bridge fails to wake up from suspend/resume(  
	Inspiron  8000 )
From: Morten Stenseth <nfp3033@privat.cybercity.no>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3A911B15.F234FEEE@uow.edu.au>
In-Reply-To: <200102182102.WAA12512@usr01.cybercity.no>  
	<3A911B15.F234FEEE@uow.edu.au>
Content-Type: multipart/mixed; boundary="=-wiLUver6EI4wMBqegAdi"
X-Mailer: Evolution (0.8 - Preview Release)
Date: 20 Feb 2001 01:00:00 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wiLUver6EI4wMBqegAdi
Content-Type: text/plain

 
> Did you enable eepro100 power management?
> 

i tried with and without power managment enabled and it fails either
way, but i have been playing with the setpci command and have
been able to restore all the pci cards/bridges to their original state
and now everything seems to work great, actually it fixed another
problem i have had with this machine , namely whenever i try
to insert agpgart after a suspend/resume the machine freezes,
but resetting the host bridge to it original seems to fix the problem.

I have included a bash script which sets the registers correct
on a inspiron 8000 ( well it works here anyways :-) ) . ,

please give me a howler if anybody want's me to
check out/test  this some more.








 


--=-wiLUver6EI4wMBqegAdi
Content-Type: text/x-sh
Content-Disposition: attachment; filename=fixpci.sh
Content-Transfer-Encoding: 7bit

#!/bin/sh  
SETPCI=/sbin/setpci

#00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory
#Controller Hub (rev 02)
DEV=00:00.0
$SETPCI -s $DEV 12.w=0xe400

#02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11) (prog-if 00 [Normal decode])
DEV=02:06.0
$SETPCI -s $DEV 20.w=0xf800
$SETPCI -s $DEV 22.w=0xf9f0
$SETPCI -s $DEV 24.w=0xfff0
$SETPCI -s $DEV 3e.w=0x0006

#08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)        Subsystem: Action Tec Electronics Inc: Unknown device 1100
DEV=08:04.0
$SETPCI -s $DEV c.w=0x2008
$SETPCI -s $DEV 4.w=0x0117
$SETPCI -s $DEV 10.w=0xf000
$SETPCI -s $DEV 12.w=0xf8ff
$SETPCI -s $DEV 14.w=0xecc1
$SETPCI -s $DEV 1a.w=0xf8e0
$SETPCI -s $DEV 3c.w=0x0b00
 


--=-wiLUver6EI4wMBqegAdi--


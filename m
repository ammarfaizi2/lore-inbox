Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSFPP7m>; Sun, 16 Jun 2002 11:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSFPP7l>; Sun, 16 Jun 2002 11:59:41 -0400
Received: from thoth.sbs.de ([192.35.17.2]:16066 "EHLO thoth.sbs.de")
	by vger.kernel.org with ESMTP id <S316289AbSFPP7l>;
	Sun, 16 Jun 2002 11:59:41 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5-3mdk 
Date: 16 Jun 2002 19:59:29 +0400
Message-Id: <1024243175.2569.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> # cat /proc/scsi/map
> # C,B,T,U Type onl sg_nm sg_dev nm dev(hex)
> 1,0,06,00 0x00 1 sg0 c:15:00 sda b:08:00
> 2,0,00,00 0x00 1 sg1 c:15:01 sdb b:08:10
> 2,0,00,01 0x00 1 sg2 c:15:02 sdc b:08:20
> 3,0,00,00 0x00 1 sg3 c:15:03 sdd b:08:30
> 3,0,00,01 0x00 1 sg4 c:15:04 sde b:08:40

The device names <-> SCSI addresses is just a part of problem. You still
are not able to assign permanent controller numbers. If you have two
SCSI controllers there is no (general) way to assure that one of them
gets 1 and another 2. (It is possible to some extent with scsihosts
parameter but only if two controllers use different drivers). Which
means that if for some reason one of them is not present (failed) you
suddenly get wrong addresses - _totally_ wrong addresses.

In some cases (LAN interfaces) it may even lead to interesting security
problem.

What is needed is a _generic_ way to assign logical controller numbers
for physical devices. Legacy devices may be ignored in this respect, but
when you have unambiguous device address (like PCI) it is possible. 

-andrej



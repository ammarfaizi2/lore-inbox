Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131206AbRC3Ii5>; Fri, 30 Mar 2001 03:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131224AbRC3Iir>; Fri, 30 Mar 2001 03:38:47 -0500
Received: from 110-moc-1.acn.waw.pl ([212.76.40.110]:6148 "HELO
	gateway.softpress.com.pl") by vger.kernel.org with SMTP
	id <S131206AbRC3Iih>; Fri, 30 Mar 2001 03:38:37 -0500
Message-ID: <004a01c0b8f4$ec6755a0$0ad1a8c0@softpress.com.pl>
From: "Andrzej Orchowski" <A.Orchowski@softpress.com.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 3c509 driver bug
Date: Fri, 30 Mar 2001 10:39:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sorry for this non-proffesional way of sending bug report and patch 
(I'm new to Linux, couldn't find utility to create patch). Fix is based
upon of the code analysis rather (and obviosly my working environment)
then 3Com tech docs. Anyway lets start...

1. Bug Summary
Inproper interface setting in 3Com 509 nic driver 1.16 (2.2)

2. Bug Description
Bug exists in 3Com 509 nic driver version 1.16 (2.2) by Donald J. Becker.
Under some circomstances the nic interface (10BaseT, AUI, BNC) is set
inproperly usually causing the card to stop working.
The unwanted and/or strange behaviour occures esspecially with more then
one 509 nics present.

Internally the code sets the interface type in if_port variable. It is set
upon of eeprom value in several places depending on the nic type:
PnP, ISA, EISA. After if_port assigment code flows to found: label
in which the different parameters are gathered together (to dev variable)
to set the nic.
Unfortunatelly in that place if_port is used condidionally which I believe
is inherited from previous driver versions.

/* Fix is simple enough not to include any attachments. Here it is */
The line (around #451)
    dev->if_port = (dev->mem_start & 0x1f) ? dev->mem_start & 3: if_port;
should be replaced simply with
    dev->if_port = if_port;

3. Keywords
networking, kernel, 3Com, 3C509, modules, drivers

4. Kernel version
I checked buggy driver is distributed with kernel version 2.2 and 2.4.2
(and probably all earlier kernel versions dated after Feb 1998).

Cheers
Andrzej Orchowski
andor@softpress.com.pl
> 


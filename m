Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbRE3K11>; Wed, 30 May 2001 06:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbRE3K1Q>; Wed, 30 May 2001 06:27:16 -0400
Received: from saarinen.org ([203.79.82.14]:62109 "EHLO vimfuego.saarinen.org")
	by vger.kernel.org with ESMTP id <S262703AbRE3K1H>;
	Wed, 30 May 2001 06:27:07 -0400
From: "Juha Saarinen" <juha@saarinen.org>
To: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Cc: <linux-smp@vger.kernel.org>, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [patch] ioapic-2.4.5-A1
Date: Wed, 30 May 2001 22:26:16 +1200
Message-ID: <045001c0e8f2$f5774d20$0a01a8c0@den2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <Pine.LNX.4.33.0105291306470.3146-200000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attachment didn't survive... please try again.

-- Juha

:: -----Original Message-----
:: From: linux-smp-owner@vger.kernel.org 
:: [mailto:linux-smp-owner@vger.kernel.org] On Behalf Of Ingo Molnar
:: Sent: Tuesday, 29 May 2001 23:11
:: To: linux-kernel@vger.kernel.org
:: Cc: linux-smp@vger.kernel.org; Alan Cox
:: Subject: [patch] ioapic-2.4.5-A1
:: 
:: 
:: 
:: the attached ioapic-2.4.5-A1 patch includes a number of 
:: important IO-APIC
:: related fixes (against 2.4.5-ac3):
:: 
::  - correctly handle bridged devices that are not listed in 
:: the mptable
::    directly. This fixes eg. dual-port eepro100 devices on 
:: Compaq boxes
::    with such PCI layout:
:: 
::     -+-[0d]---0b.0
::      +-[05]-+-02.0
::      |      \-0b.0
::      \-[00]-+-02.0
::             +-03.0-[01]--+-04.0    <=== eth0
::             |            \-05.0    <=== eth1
::             +-0b.0
::             +-0c.0
::             +-0d.0
::             +-0e.0
::             +-0f.0
::             +-14.0
::             +-14.1
::             +-19.0
::             +-1a.0
::             \-1b.0
:: 
::    without the patch the eepro100 devices get misdetected as 
:: XT-PIC IRQs
::    and their interrupts are stuck.
:: 
::  - the srcbus entry in the mptable does not have to be 
:: translated into
::    a PCI-bus value.
:: 
::  - add more APIC versions to the whitelist
:: 
::  - initialize mp_bus_id_to_pci_bus[] correctly, so that we can detect
::    nonlisted/bridged PCI busses more accurately.
:: 
:: the patch should only affect systems that were not working properly
:: before, but it might break broken-mptable systems - we'll see.
:: 
:: 	Ingo
:: 


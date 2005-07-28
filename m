Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVG1Rby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVG1Rby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVG1Rbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:31:51 -0400
Received: from ngate.noida.hcltech.com ([202.54.110.230]:52365 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S262206AbVG1Rbi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:31:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
Subject: Query on physical mode support for IPI for i386
Date: Thu, 28 Jul 2005 23:00:53 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <40CC5CC7CDACC048B1299C57025E330C661D17@HSDLNTD1110010.noida.hcltech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Query on physical mode support for IPI for i386
Thread-Index: AcWTmhraUdzhWzD0SzOd1WZkbiYwkQ==
From: "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
To: <mingo@redhat.com>, <alan@redhat.com>
Cc: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I am working on Intel IA32 platform on linux kernel 2.6.8. Primarily I
am looking at Inter Processor Interrupts (IPI) on APIC. As per my
understanding Linux supports Logical mode of IPI. I want to change it to
physical mode (please don't ask why ??). Can anybody tell me what all
things I need to change ?

More explanation of problem:
======================
Intel architecture's APIC functionality supports IPI also, which are
useful in SMP. For IPI functionality each processor's local APIC
provides ICR register (Interrupt command register) and this is the basic
register for controlling IPI mechanism.

Setting destination mode field of ICR register can change the mode from
physical to logical. As per my understanding Linux IPI mechanism work
under logical mode only. There is no support for physical mode (however
ppl may argue that it is not needed.. I agree.. But due to some reason I
need it..)

Search Till now and queries:
==================== 
Till this point of time I can figure out following changes : -
	1. Need to change function __prepare_ICR
(arch/asm-i386/kernel/smp.c) in case of destination shorthand is not
used that is value of shortcut is 0.
	2. Need to pass physical APIC_ID in __prepare_ICR2() function
calls.
		- Here I am not sure how to get physical APIC_ID for the
destination processor ? Is there any standard function available for
this ?
	3. Also If I change according to 2 then I think I need to change
the code in kernel where Linux handles logical mode (that is look for
DFR and LDR registers)
		- I am not able to figure out the location of the code
in kernel. Can anybody let me know the location of code ? 

Also if somebody can suggest me what else needs to be change then it
would be great help for me ? Any pointer in this regard will be useful.

Finally correct me if somewhere my understanding is not correct OR I
have mentioned something wrong.

TIA

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Deepak Kumar Gupta
Project Leader
System Software Group
HCL Technologies Limited
Noida UP

Contributing to the World by creating indispensable value !

System Software CoE @ HCLT-Noida
http://www.hcltechnologies.com
Ph. : +91-120-2510701/702 Ext : 3159
FAX : +91-120-2510713 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


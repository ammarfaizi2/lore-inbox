Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269125AbUINDg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269125AbUINDg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUINDg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:36:26 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:28429 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S269125AbUINDgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:36:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/2] Incorrect PCI interrupt assignment on ES7000 for platform GSI
Date: Mon, 13 Sep 2004 22:36:02 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04220261@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/2] Incorrect PCI interrupt assignment on ES7000 for platform GSI
Thread-Index: AcSaA7c6lowaLGrFQ2WJ06seMBhoowAA+yZw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Tonnerre" <tonnerre@thundrix.ch>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 14 Sep 2004 03:36:03.0593 (UTC) FILETIME=[F6030F90:01C49A0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff -puN arch/i386/kernel/acpi/boot.c~mypatch
arch/i386/kernel/acpi/boot.c
>> --- linux/arch/i386/kernel/acpi/boot.c~mypatch	2004-09-13
14:08:21.192015024 -0600
>> +++ linux-root/arch/i386/kernel/acpi/boot.c	2004-09-13
14:10:51.457171248 -0600
>> @@ -442,6 +442,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
unsigned 
>> int acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)
{
>>  	unsigned int irq;
>> +	unsigned int plat_gsi;
>>  
>>  #ifdef CONFIG_PCI
>>  	/*
>> @@ -463,10 +464,10 @@ unsigned int acpi_register_gsi(u32 gsi,
>>  
>>  #ifdef CONFIG_X86_IO_APIC
>>  	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC) {
>> -		mp_register_gsi(gsi, edge_level, active_high_low);
>> +		plat_gsi = mp_register_gsi(gsi, edge_level,
active_high_low);
>>  	}
>>  #endif
>> -	acpi_gsi_to_irq(gsi, &irq);
>> +	acpi_gsi_to_irq(plat_gsi, &irq);
>>  	return irq;
>>  }
>>  EXPORT_SYMBOL(acpi_register_gsi);
>
> Looking at that,  won't that cause problems if  we don't have IOAPIC?
> Then you end up using an undefined value as GSI.

Oops, you are right! thanks for catching this. 
I guess it would be OK to do:

int acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)  {
 	unsigned int irq;
+	unsigned int plat_gsi = gsi;


--Natalie

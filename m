Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSG2JMN>; Mon, 29 Jul 2002 05:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSG2JMN>; Mon, 29 Jul 2002 05:12:13 -0400
Received: from mail.medav.de ([213.95.12.190]:58385 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S314080AbSG2JML> convert rfc822-to-8bit;
	Mon, 29 Jul 2002 05:12:11 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Lionel Bouton" <Lionel.Bouton@inet6.fr>
Cc: "L.C. Chang" <lcchang@sis.com.tw>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Date: Mon, 29 Jul 2002 11:15:56 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <20020729105626.A16395@bouton.inet6-interne.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: SiS 5513 ATA133 support patch for 2.4.19-rc3-ac3
Message-Id: <20020729090713.BD679106A8@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002 10:56:26 +0200, Lionel Bouton wrote:

>On lun, jui 29, 2002 at 09:11:34 +0200, Daniela Engert wrote:
>> On Mon, 29 Jul 2002 01:37:54 +0200, Lionel Bouton wrote:
>> 
>> 
>> Lionel,
>> 
>> as you already figured out, looking at the northbridge IDs is simply
>> not sufficient to find out which capabilities and register layout the
>> IDE controller in the southbridge (no matter if integrated or external)
>> has.
>> 
>> Some comments:
>> 
>> 1) the 745 has an integrated southbridge and an ATA/100 capable IDE
>> controller
>> 
>
>I believed so too, but Lei-Chun patch changed it to ATA133.
>Lei-Chun, could you tell us what we can expect from 745 chips ?

I have a user report indicating that:

PCI BIOS V2.10 detected, 2 PCI buses present.
Found embedded SiS 5513 on 0/2/5
00:  39 10 13 55  07 00 00 00  D0 80 01 01  00 80 80 00  
10:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  
20:  01 40 00 00  00 00 00 00  00 00 00 00  19 10 41 0A  
30:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  
40:  31 81 31 82  31 00 31 00  08 01 E6 33  00 02 00 02  
50:  01 00 01 06  00 00 00 00  00 00 00 00  00 00 00 00  
BusMaster Registers:
00:  08 00 60 00  58 28 F6 00  00 00 04 00  FC 5F 00 00  

VendorID 1039, DeviceID 5513, Subsystem VendorID 1019, DeviceID 0A41
IOBase      4000h (Len 10h)

Host bridge (1039/0745 rev 01) on 0/0/0
South bridge (1039/0008 rev 00) on 0/2/0

The primary master is a UDMA 5 disk, and primary slave a UDMA 4 one.

>> 2) the 646 (and most likely the 645 and others as well) may be paired
>> with a 961 (ATA/100) or 961B (ATA133) MutIOL southbridge with different
>> register programming values.
>> 
>> Thus simply ripping out some northbridge IDs wouldn't prevent
>> corruption problems.
>> 
>
>I don't see why (unless you refer to the 962/963 problem I did mention).
>If we remove the IDs, the chips will be detected as SiS5513 (ATA_16). If
>I'm correct, in this mode (only allowing PIO modes and SW/MW DMA modes)
>all chips are OK.
>I didn't dig in all specs to check each config register change, but all I
>saw was OK and I *never* received any data corruption report for a chip that
>was configured as original SiS5513 (though I have many reports of bad
>performance due to PIO modes being used in such cases).

Ok, I think you are right, disabling UDMA mode should be a safe bet.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11



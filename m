Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268578AbRG3MuP>; Mon, 30 Jul 2001 08:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268576AbRG3MuH>; Mon, 30 Jul 2001 08:50:07 -0400
Received: from mail.medav.de ([213.95.12.190]:54799 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S268577AbRG3Mt7> convert rfc822-to-8bit;
	Mon, 30 Jul 2001 08:49:59 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 30 Jul 2001 08:04:54 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.00
In-Reply-To: <20010729222830.A25964@pckurt.casa-etp.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: VIA KT133A / athlon / MMX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <20010730125012Z268576-720+7896@vger.kernel.org>
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Kurt!

On Sun, 29 Jul 2001 22:28:30 +0200, Kurt Garloff wrote:

>Me neither. I was hoping that only a bit differs. Unfortunately that's not
>the case, so I need to have a look in the datasheet.
>But those are not publically available :-(
>Anybody having them?

Try to get a clue yourself from the WPCREDIT KT133 plugin (see below,
stripped down to the differing registers). Some differences look
suspicious to me...

>Working:

>> 00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 00 00 00
>                                              ^ Latency.
>> 50: 17 a3 eb b4 02 00 10 10 c0 00 08 10 10 10 10 10
>                  ^^ ^^
>> 60: 03 aa 02 20 e6 d6 d6 c6 51 28 43 0d 08 3f 00 00
>                              ^^       ^^
>> a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 2b 12 14 00
>                                          ^^
>> b0: 49 da 00 60 31 ff 80 05 67 00 00 00 00 00 00 00
>            ^^
>> f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00
                                                ^^ ^^

>Buggy: (Own, buggy settings in parens)

>> 00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 08 00 00
>                                              ^ Latency
>> 50: 17 a3 eb b4 43 89 10 10 c0 00 08 10 10 10 10 10
>                  ^^ ^^				(47 8d here)
>> 60: 03 aa 02 20 e6 d6 d6 c6 45 28 43 0f 08 3f 00 00
>                              ^^       ^^		(41 .. 21 here)
>> a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 2f 12 14 00
>                                          ^^		(6b here)
>> b0: 49 da 88 60 31 ff 80 05 67 00 00 00 00 00 00 00
>            ^^						(22 here)
>> f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 91 06
>                                                ^^ ^^	(00 00 here)

PCR(PCI Configration Registers) Editor / WPCREDIT for WIN32
Copyright (c) 2000  H.Oda!

[COMMENT]=for HWup ng. members (Kx) edited by Guruad tnx to author
H.Oda!
[MODEL]=VT8363 (KT133)
[VID]=1106:VIA
[DID]=0305:Host to PCI Bridge

[54:7]=SDRAM Self-Refresh	0=disable   1=enable
[54:6]=Probe Next Tag State T1	0=disable   1=enable
[54:5]=High Priority DRAM Req.	0=disable   1=enable
[54:4]=Continuous DRAM Request	0=disable   1=enable
[54:3]=DRAM Speculative Read	0=disable   1=enable
[54:2]=PCI Master Pipeline Req. 0=disable   1=enable
[54:1]=PCI-to-CPU / CPU-to-PCI	0=disable   1=enable
[54:0]=Fast Write-to-Read	0=disable   1=enable

[55:0]=S2K Compensation CPU Halt0=disable   1=enable

[68:7]=SDRAM Open Page Control	0=precharge  1=remain act
[68:6]=Bank Page Control	0=same bank  1=different
[68:5]=(Reserved)
[68:4]=DRAM Data Latch Delay	0=Latch     1=Delay latch
[68:3]=EDO Test Mode		0=disable   1=enable
[68:2]=Burst Refresh(4 times)	0=disable   1=enable
[68:1]=System Frequency Divider 00= 66 MHz  01=100 MHz
[68:0]=10=133 MHz  11=Reserved

[6B:7]=Arbitration Parking Pol. 00=bus owner 01=CPU side
[6B:6]=10=AGP side  11=Reserved
[6B:5]=Fast Read to Write t-a	0=disable   1=enable
[6B:4]=(Reserved)
[6B:3]=MD Bus Second Level	0=Normal slew 1=More
[6B:2]=CAS Bus Second Level	0=Normal slew 1=More
[6B:1]=Virtual Channel-DRAM	0=disable   1=enable
[6B:0]=Multi-Page Open		0=disable   1=enable

[AC:7]=(Reserved)
[AC:6]=AGP Read Synchronization 0=disable   1=enable
[AC:5]=AGP Read Snoop DRAM P-W-B0=disable   1=enable
[AC:4]=GREQ# Priority		0=disable   1=enable
[AC:3]=2X Rate Supported	0=not	    1=supported
[AC:2]=LPR In-Order Access	0=not	    1=executed
[AC:1]=AGP Arbitration Parking	0=disable   1=enable
[AC:0]=AGP-PCI Master/CPU-PCI TC0=2T or 3T  1=1T

[B2:7]=GD/GBE/GDS, SBA/SBS Ctrl
[B2:6]=(Reserved)
[B2:5]=(Reserved)
[B2:4]=GD[31-16] Staggered Delay0=none	    1=1ns
[B2:3]=(Reserved)
[B2:2]=(Reserved)
[B2:1]=AGP Voltage		0=1.5V	    1=3.3V
[B2:0]=GDS Output Delay 	0=none	    1=0.4ns

[FE]=Back-Door Device ID
[FF]=Back-Door Device ID

'54'=BIU Control 00 RW
'55'=Debug (Do Not Program)
'68'=DRAM Control 00 RW
'6B'=DRAM Arbitration Control 01 RW
'AC'=AGP Control 00 RW
'B2'=AGP Pad Drive / Delay Control 00 RW
'FE..FF' Back-Door Device ID 0000 RW

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11



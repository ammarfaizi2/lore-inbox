Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289355AbSBEJEJ>; Tue, 5 Feb 2002 04:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSBEJD7>; Tue, 5 Feb 2002 04:03:59 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27663 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289355AbSBEJDr>; Tue, 5 Feb 2002 04:03:47 -0500
Message-Id: <200202050856.g158uXt18671@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Serguei Miridonov <mirsev@cicese.mx>, calin@ajvar.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon Optimization Problem
Date: Tue, 5 Feb 2002 10:56:20 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C5F4FF4.9425949E@cicese.mx>
In-Reply-To: <3C5F4FF4.9425949E@cicese.mx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2002 01:22, Serguei Miridonov wrote:
> Just as followup... I was trying to find a minimum deviation
> from BIOS settigns to make Soyo Dragon Plus stable:
>
> In KT266A northbridge 1106:3099:
>
> Reg[0x75] = 0x07; // this was set to 0x01 by BIOS
> Reg[0x76] = 0x00; // this was 0x10
> Without this change I had filesystem corruptions during
> kernel compilation...

[MODEL]=VT8366 (KT266) Athlon NB
[VID]=1106:VIA
[DID]=3099:Host to PCI Bridge

[75:7]=Arbitration Mode         0=REQ-based 1=Frame-based
(75:6)=CPU Latency Timer                read only
(75:5)=(same as above)
(75:4)=(same as above)
[75:3]=(Reserved)
[75:2]=PCI Master Bus Time-Out  000=Disable
[75:1]=001=1x32 PCICLKs         010=2x32 PCICLKs
[75:0]=011=3x32 PCICLKs ...     111=7x32 PCICLKs

Note: other doc I have (for KT266A) says 75.3 is used for PCI Master Bus 
Time-Out too (thus max timeout is 1111 = 15x32 PCICLKs)

[76:7]=I/O Port 22 Enable
[76:6]=(Reserved)
[76:5]=Master Priority Rotation 0x=every PCI master grant
[76:4]=10=after every 2 PCI     11=after every 3 PCI
[76:3]=REQn# to REQ4# Mapping   00=REQ4#    01=REQ0#
[76:2]=10=REQ1#    11=REQ2#
[76:1]=(Reserved)
[76:0]=REQ4# Is High Priority   0=disable   1=enable

KT266A doc says:
76.5-4: Master Priority Rotation: 00 disable
        01 every PCI master grant
        10 every 2 PCI master grant
        11 every 3 PCI master grant
--
vda

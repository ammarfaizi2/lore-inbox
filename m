Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317773AbSFSFNN>; Wed, 19 Jun 2002 01:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317774AbSFSFNM>; Wed, 19 Jun 2002 01:13:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11791 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317773AbSFSFNK>; Wed, 19 Jun 2002 01:13:10 -0400
Message-Id: <200206190509.g5J59bL11170@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Jonathan A. Davis" <davis@jdhouse.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VIA KT266 PCI-related crashes fixed.  Now whats the catch?
Date: Wed, 19 Jun 2002 08:10:11 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206182240330.29752-100000@bacchus.jdhouse.org>
In-Reply-To: <Pine.LNX.4.44.0206182240330.29752-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2002 02:13, Jonathan A. Davis wrote:
> G'day Alan, all,
>
> In November, I assembled a new machine using a Soyo Dragon+ mb with a
> Pinnacle PCTV/Pro card as the only add-in board (I have an ATI 7500 in the
> AGP slot).  Very quickly I learned that any heavy disk activity (from two
> UDMA100 drives) during TV card use would lock the system tight.  As long
> as I didn't use the TV card, the system was completely solid -- under
> heavy disk, sound, net usage, etc.  I tried moving the card around,
> playing with BIOS, upgrading BIOS, with no success.  I dug around in
> quirks.c and put a serious dent in google's usage reports trying to find
> answers.  About the time I was concluding that I had a defective mb, a
> friend decided to install Linux on his KT266 system also.  After the
> install, we popped a PCTV (non-PRO minus FM radio) into it and ended up
> duplicating my machines's crashing behaviour.
>
> About a month ago, after giving up and either avoiding TV card use (which
> given the state of US TV isn't a completely bad thing :-), or resigning
> myself to not doing serious work if I had the TV card on, I stumbled
> across Serguei Miridonov's site (http://www.cicese.mx/~mirsev/Linux/VIA/).
> His small module changes PCI config register 0x75 from 0x01 to 0x07 and
> clears all the bits on 0x76 (originally set to 0x10 on my mb).  The result
> has been perfect stability for both boards with TV cards and as much disk
> and other I/O as bonnie and friends could generate.

[75:7]=Arbitration Mode         0=REQ-based 1=Frame-based
(75:6)=CPU Latency Timer                read only
(75:5)=(same as above)
(75:4)=(same as above)
[75:3]=(Reserved)
[75:2]=PCI Master Bus Time-Out  000=Disable
[75:1]=001=1x32 PCICLKs         010=2x32 PCICLKs
[75:0]=011=3x32 PCICLKs ...     111=7x32 PCICLKs

You increased busmaster timeout sevenfold here.

[76:7]=I/O Port 22 Enable
[76:6]=(Reserved)
[76:5]=Master Priority Rotation 0x=every PCI master grant
[76:4]=10=after every 2 PCI     11=after every 3 PCI
[76:3]=REQn# to REQ4# Mapping   00=REQ4#    01=REQ0#
[76:2]=10=REQ1#    11=REQ2#
[76:1]=(Reserved)
[76:0]=REQ4# Is High Priority   0=disable   1=enable

Heh... doc says 0x00 and 0x10 are the same for reg 0x76...
did you test with 0x76 unchanged?

I have a PDF also, need to reboot into WinNT to look at it...
KDE's PDF viewer can't grok it.
--
vda

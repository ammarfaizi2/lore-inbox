Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSJZBzR>; Fri, 25 Oct 2002 21:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJZBzR>; Fri, 25 Oct 2002 21:55:17 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:64680 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261801AbSJZBzQ>; Fri, 25 Oct 2002 21:55:16 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Cajoline'" <cajoline@andaxin.gau.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ASUS TUSL2-C and Promise Ultra100 TX2
Date: Sat, 26 Oct 2002 03:59:27 +0200
Message-ID: <008701c27c93$50d9c140$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-reply-to: <008601c27c91$17671950$020da8c0@nitemare>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cajoline writes:
 
> I recently setup a box with the following components:
> Intel Celeron 1300 MHz
> ASUS TUSL2-C motherboard
> 2 x Promise Ultra100 TX2 controllers

I have a CUSL2-C board, P3-800 Coppermine and a Ultra133TX2 controller.

> Any 2.4 kernel I have tried on this machine displays this strange
> a
> behavior: any drives attached to the PDC controllers only work at udma
> mode 2 (UDMA33).

I have the same problem. This is a known problem in the vanilla kernels
(still in 2.4.20-pre11). You can force the right UDMA setting by giving
a "ideX=ata66" kernel boot parameter, where the "X" is your interface
number. This is fixed in recent -ac kernels (I tested with
2.4.20-pre10-ac2).

> What's even funnier is that if I try to copy files from a 
> filesystem on
> a
> 
> drive attached to a PDC20268 and a drive attached to the motherboard
> controller (PIIX4 chipset), the system eventually locks up 
> (after about
> 3
> GB).
> What I mean by this is that there are no errors whatsoever, from the
> kernel ide driver, from the filesystem, nothing at all. It just stops
> responding to anything: login at the console, shell commands, network
> daemons, everything stops working. You can't even reboot it - a hard
> reset
> is required.

This is nasty, I experience this too. This is different from the problem
you describe earlier. I already checked different recent kernels, BIOS
versions, NICs, memory, processors, and still it hangs. I suspect it's a
unknown bug in the driver or a hardware bug in the controller. The
problem is that it hangs completely dead, giving no information to start
debugging. :(

> So I have come to the conclusion there must be some rather bizarre
> 
> incompatibility between the PDCs and this motherboard.
> Let me note that the PDC controllers do work just fine with 
> other older
> motherboards.

Like you, I also have other boxes with Promise Ultra66/100/133
controllers, with _different_ motherboards, which indeed don't have such
problem, so the combination of motherboard <-> controller looks
important here.

> And another thing, during boot-up, the PDCs do show the
> drives attached to it, detected at the right udma mode.

Ditto.
 
> I was wondering if anyone has come across this specific problem. I
> browsed
> 
> thoroughly through the list archives, but I didn't find any mention of
> the
> specific motherboard, or even the PIIX4 chipset and these controllers.
> I know there is probably no way I can get this hardware to work
> together,
> yet I'm curious to know if this has occurred to someone else as well.

Well, it has. And I'm still hoping to solve this one. I an open to any
suggestions, patches or tests.

Regards,
- Robbert Kouprie


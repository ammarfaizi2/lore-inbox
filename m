Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316177AbSEOOiJ>; Wed, 15 May 2002 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316178AbSEOOiI>; Wed, 15 May 2002 10:38:08 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:36103 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316177AbSEOOiB>; Wed, 15 May 2002 10:38:01 -0400
Message-Id: <200205151435.g4FEZo990223@aslan.scsiguy.com>
To: Andrey Nekrasov <andy@spylog.ru>
cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2 
In-Reply-To: Your message of "Wed, 15 May 2002 17:03:28 +0400."
             <20020515130328.GA19698@spylog.ru> 
Date: Wed, 15 May 2002 08:35:50 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello.
>
>Hardware motherboard: Intel "Lancewood" L440GX, SCSI integrated, last BIOS/BMC
>
>1. 2.4.19pre1aa1 :  : 1CPU/HIGHMEM/3.5Gb

The key bit in the dump is this:

>scsi0:0:0:0: Attempting to queue an ABORT message
>...
>scsi0:0:4:0: Command already completed

Interrupts are not getting routed correctly for your motherboard
in the 2.4.19pre release you are running.  I'm not sure what has
changed there, but the aic7xxx driver is noticing, when told to
abort a command, that it has already completed, but the interrupt
for that completion was never received.  You may see different
results if you play with the APIC I/O option.

--
Justin

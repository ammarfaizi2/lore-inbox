Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSL1SFI>; Sat, 28 Dec 2002 13:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSL1SFI>; Sat, 28 Dec 2002 13:05:08 -0500
Received: from host194.steeleye.com ([66.206.164.34]:47376 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266270AbSL1SFH>; Sat, 28 Dec 2002 13:05:07 -0500
Message-Id: <200212281813.gBSIDNP02885@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Manfred Spraul <manfred@colorfullife.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from Manfred Spraul <manfred@colorfullife.com> 
   of "Sat, 28 Dec 2002 18:54:49 +0100." <3E0DE569.9070108@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 12:13:23 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manfred@colorfullife.com said:
> You are aware that "users" is not one or two drivers that noone uses,
> it's the whole networking stack. 

I am aware of this.  I'm also aware that it is *currently* broken with the old 
API on all non-coherent arch's bar the one you point out.

All I actually did was document the existing problem, I think.

How bad actually is it?  Networking seems to work fine for me on non-coherent 
parisc.  Whereas, when I had this cache line overlap problem in a SCSI driver, 
I was seeing corruption all over the place.

The problem really only occurs if the CPU can modify part of a cache line 
while a device has modified memory belonging to another part.  Now a flush 
from the CPU will destroy the device data (or an invalidate from the driver 
destroy the CPU's data).  The problem is effectively rendered harmless if only 
data going in the same direction shares a cache line (even if it is for 
different devices).  It strikes me that this is probably true for network data 
and would explain the fact that I haven't seen any obvious network related 
corruption.

James



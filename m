Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSHQRFq>; Sat, 17 Aug 2002 13:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSHQRFq>; Sat, 17 Aug 2002 13:05:46 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:26556 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S317508AbSHQRFp>;
	Sat, 17 Aug 2002 13:05:45 -0400
Message-ID: <3D5E8346.5010101@iram.es>
Date: Sat, 17 Aug 2002 19:09:26 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
References: <Pine.LNX.4.44.0208171810260.29714-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Sat, 17 Aug 2002, James Bottomley wrote:
> 
> 
>>The boot problem only happens with my quad pentium cards, the dyad
>>pentium and 486 are fine.  Originally, a voyager system with quad cards
>>just wouldn't boot (this was in the 2.2.x days).  Eventually, by trial
>>and error and long debug of the boot process I discovered it would boot
>>if the GDT was 8 bytes aligned (actually, the manuals say it should be
>>16 byte aligned, so perhaps we should also add this to the Linux
>>setup.S?). [...]
> 
> 
> indeed it's not aligned:
> 
> 	c010025c T cpu_gdt_descr

Hey no, it's cpu_gdt_table that must be aligned. That one does not matter, 
it's only used once for the lgdt instruction...

Ingo, for the layout of the gdt also, the location of the TSS descriptor
is irrelevant AFAICT. It's only used when doing the initial LTR, after 
that it's never referenced by the CPU.

	Gabriel.


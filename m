Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSHQPNK>; Sat, 17 Aug 2002 11:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSHQPNJ>; Sat, 17 Aug 2002 11:13:09 -0400
Received: from host194.steeleye.com ([216.33.1.194]:15372 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318013AbSHQPNJ>; Sat, 17 Aug 2002 11:13:09 -0400
Message-Id: <200208171516.g7HFGpK03104@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Ingo Molnar <mingo@elte.hu>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch 
In-Reply-To: Message from Ingo Molnar <mingo@elte.hu> 
   of "Sat, 17 Aug 2002 08:51:47 +0200." <Pine.LNX.4.44.0208170845250.3209-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Aug 2002 10:16:51 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu said:
> while your patch looks OK, it would be *really* interesting to find
> out why the previous layout failed. Does the BIOS somehow corrupt the
> GDT? You are using the stock SMP code otherwise, correct? And this
> part of the patch: 

Well, I should say, this is the voyager MCA box again...

The boot problem only happens with my quad pentium cards, the dyad pentium and 
486 are fine.  Originally, a voyager system with quad cards just wouldn't boot 
(this was in the 2.2.x days).  Eventually, by trial and error and long debug 
of the boot process I discovered it would boot if the GDT was 8 bytes aligned 
(actually, the manuals say it should be 16 byte aligned, so perhaps we should 
also add this to the Linux setup.S?).  SUS (the voyager BIOS equivalent) 
reports that the CPU took a Trap 6 at FFF38466 in the boot sequence, but I 
knew there wasn't an illegal instruction, and the memory address isn't in the 
boot code. I suspect that the quad cards have some real mode instruction 
emulation and that's where the trap is occuring.

Unfortunately, all the people at NCR who could explain what is going on have 
long since departed, so I'm afraid I can only guess.

However, the general point that we should keep the boot sequence as simple as 
possible (just in case we run across any other wierd quirks even in modern 
PCs) still remains.

James



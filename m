Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318898AbSH1Pu5>; Wed, 28 Aug 2002 11:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSH1Pud>; Wed, 28 Aug 2002 11:50:33 -0400
Received: from kim.it.uu.se ([130.238.12.178]:7330 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318898AbSH1Ps4>;
	Wed, 28 Aug 2002 11:48:56 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15724.61927.221405.274843@kim.it.uu.se>
Date: Wed, 28 Aug 2002 17:53:11 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
In-Reply-To: <1030506106.1489.27.camel@ldb>
References: <1030506106.1489.27.camel@ldb>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri writes:
 > This patch implements a system that modifies the kernel code at runtime
 > depending on CPU features and SMPness.
 >...
 > /* If we are running on SMP any other processor might be executing the
 >    code that we are modifying. We must make sure that the other
 >    processor will either fault or will execute the complete
 >    replacement instruction.
 > 
 >    This is accomplished by using instructions that fault only
 >    depending on up to 4 bytes. When fixing up something we first write
 >    bytes after the first 4 and we then use a locked write to set the
 >    first 4.
 > 
 >    We depend on the processor execute unit to never see our locked
 >    write before it sees the other modifications.
 >    
 >    According to page 7-5 of the Intel Pentium 4 System Programming
 >    Manual, this is safe on 486 and Pentium <= 4.

I've tried this sort of thing before (unsynchronised cross-modifying code),
but I had to abandon it due to Pentium III Erratum E49 and similar errata
for all Intel P6 CPUs. Have you verified that you're not hitting this erratum?

/Mikael

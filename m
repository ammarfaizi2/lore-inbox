Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292888AbSCWBPH>; Fri, 22 Mar 2002 20:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSCWBO5>; Fri, 22 Mar 2002 20:14:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292700AbSCWBOr>;
	Fri, 22 Mar 2002 20:14:47 -0500
Subject: Re: mprotect() api overhead.
To: Tony.P.Lee@nokia.com
Date: Sat, 23 Mar 2002 01:03:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2043@mvebe001.NOE.Nokia.com> from "Tony.P.Lee@nokia.com" at Mar 22, 2002 02:10:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oZvx-00010N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	For x86 system, is there way to specify 4MB page table entry
> 	instead of 4K page table entry when use the mmap() api.  
> 	With 4MB mmap() page table entry, mprotected should take only
> 	8 iterations to change the access bits for 32 MB of share
> 	memory as compare to 8k iterations for 4k page table entries.
> 	Am I corrected on this?

The mainstream kernel has no real support for 4Mb pages - some experimental
work has been done but little else. Even then the TLB flush has a non
trivial overhead. On SMP the effect will be more significant since it
must ensure the other threads on other processors also see updated page 
tables.

Alan

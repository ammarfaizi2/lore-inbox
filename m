Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRJLSDc>; Fri, 12 Oct 2001 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJLSDX>; Fri, 12 Oct 2001 14:03:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11791 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276021AbRJLSDE>; Fri, 12 Oct 2001 14:03:04 -0400
Subject: Re: kapm-idled Funny in 2.4.10-ac12?
To: gallir@uib.es
Date: Fri, 12 Oct 2001 19:08:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20011012193019.A612@linux.uib.es> from "Ricardo Galli" at Oct 12, 2001 07:30:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15s6js-0008Pf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am having almost the same problem in 2.4.12-ac1:
> 
> gallir@linux:~$ uname -a
> Linux linux 2.4.12-ac1 #2 Fri Oct 12 19:01:03 CEST 2001 i686 unknown
> 
> kapm-idled consumes a 14% of CPU (in a P3 1GHz)
> 
> PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>   3 root      17   0     0    0     0 RW   14.3  0.0   1:17 kapm-idled
> 
> The same happens with vanilla Linus tree (tested up to 2.4.11). In a P2,
> CPU consuption was more than 85%.
> 
> The CPU's temperature, while the system idle, is more than 4 degrees (C)
> higher than the same conditions with the kapm-idled disabled.

I've been reading throught the APM spec and code a bit further. The more
I read the more I wonder quite how our idle code is meant to work and what
kind of beer was overconsumed during its writing.

There are two glaring issues I can see right now

#1	The BIOS might sleep for a tick, but it is also is allowed to slow
	the cpu and return straight back to us.

	If it returns back to us we spin in a tight loop at the lower clock
	speed calling the APM bios. Not ideal.

	Just fixed that in my tree for the next -ac

#2	We test system_idle() nr_running==1, but we spent all our time 
	pretending we aren't running. Im not 100% sure the test is safe
	yet

Alan

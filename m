Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286124AbRLJAdY>; Sun, 9 Dec 2001 19:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286123AbRLJAdQ>; Sun, 9 Dec 2001 19:33:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22291 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286120AbRLJAc7>; Sun, 9 Dec 2001 19:32:59 -0500
Subject: Re: Linux 2.4.17-pre5
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 10 Dec 2001 00:41:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <E16DECH-0001bM-00@wagner> from "Rusty Russell" at Dec 10, 2001 11:21:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DEVr-0008SW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	If you number each CPU so its two IDs are smp_num_cpus()/2
> 	apart, you will NOT need to put some crappy hack in the
> 	scheduler to pack your CPUs correctly.

Which is a major change to the x86 tree and an invasive one. Right now the
X86 is doing a 1:1 mapping, and I can offer Marcelo no proof that somewhere
buried in the x86 arch code there isnt something that assumes this or mixes
a logical and physical cpu id wrongly in error. 

At best you are exploiting an obscure quirk of the current scheduler that is
quite likely to break the moment someone factors power management into the
idling equation (turning cpus off and on is more expensive so if you idle
a cpu you want to keep it the idle one for PM). Congratulations on your
zen like mastery of the scheduler algorithm. Now tell me it wont change in
that property.

> > For 2.5 the scheduler needs a rewrite anyway so its a non issue there.
> 
> Disagree.  Without widespread understanding of how the simple
> scheduler works, writing a more complex one is doomed.

The simple scheduler doesn't work. I've run about 20 schedulers on playing
cards, and at the point you are shuffling things around and its clear what 
is happening its actually hard not to start laughing at the current
scheduler once you hit a serious load or serious amounts of processors.

Its a great scheduler for a single or dual processor 486/pentium type box
running a home environment. It gets a bit flaky by the time its running
oracle on a 4 way, it gets very flaky by the time its running lotus back
ends on an 8 way. It doesn't take luancy like java, broken JVM implementations
and volcanomark to make it go astray

Alan

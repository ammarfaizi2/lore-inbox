Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbULPBsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbULPBsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbULPBkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:40:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45697 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262589AbULPBjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:39:20 -0500
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
References: <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
	 <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com>
	 <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
	 <41BC0854.4010503@colorfullife.com>
	 <20041212093714.GL16322@dualathlon.random>
	 <41BC1BF9.70701@colorfullife.com>
	 <20041212121546.GM16322@dualathlon.random>
	 <1103060437.14699.27.camel@krustophenia.net>
	 <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu>
	 <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103157476.3585.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 00:37:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-14 at 23:09, Linus Torvalds wrote:
> On Tue, 14 Dec 2004, Ingo Molnar wrote:
> Now that you mention it, I have this dim memory of the one-instruction
> "sti-shadow" actually disabling NMI's (and debug traps) too. The CPU 
> literally doesn't test for async events following "sti". 
> 
> Or maybe that was "mov->ss". That one also has that strange "black hole"  
> for one instruction.

The mov to ss one is a bit more magic than that however. If you write
3Gb of mov->ss into memory (ie about 64 pages to thrash the cache and
slow it plus mmap repeatedly) and run it you don't get a vastly long irq
delay at least on intel, not tried the others. 

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbULPPJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbULPPJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbULPPJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:09:09 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35345 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262692AbULPPI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:08:26 -0500
Date: Thu, 16 Dec 2004 15:08:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
In-Reply-To: <20041216145159.GA3204@elte.hu>
Message-ID: <Pine.LNX.4.58L.0412161501190.15472@blysk.ds.pg.gda.pl>
References: <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random>
 <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random>
 <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
 <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
 <1103157476.3585.33.camel@localhost.localdomain> <Pine.LNX.4.58.0412151756550.3279@ppc970.osdl.org>
 <20041216145159.GA3204@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Ingo Molnar wrote:

> c0125ee9:     1529 	fa                   	cli    
>                  ^---------------------------------- # of profiler hits
> c0125eea:      507 	fb                   	sti    
> c0125eeb:        0 	fa                   	cli    
> c0125eec:     3719 	fb                   	sti    
> c0125eed:        0 	fa                   	cli    
> c0125eee:     1579 	fb                   	sti    
> c0125eef:        0 	fa                   	cli    
> c0125ef0:     3317 	fb                   	sti    
> c0125ef1:        0 	fa                   	cli    
> c0125ef2:     3030 	fb                   	sti    
> c0125ef3:        0 	fa                   	cli    
> c0125ef4:     2497 	fa                   	cli    
> c0125ef5:     1055 	fb                   	sti    
> c0125ef6:        0 	fa                   	cli    
[...]
> the 'cli' is always a 'black hole' to the NMI, while the second of two
> consecutive cli's are not.

 It looks like the 'sti' is actually the black hole -- remember interrupts
are traps, that is they are probed for and taken after instruction
execution.

  Maciej

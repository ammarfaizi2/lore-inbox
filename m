Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbULPPN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbULPPN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbULPPN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:13:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7126 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262700AbULPPMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:12:02 -0500
Date: Thu, 16 Dec 2004 16:11:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041216151126.GA17066@elte.hu>
References: <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org> <1103157476.3585.33.camel@localhost.localdomain> <Pine.LNX.4.58.0412151756550.3279@ppc970.osdl.org> <20041216145159.GA3204@elte.hu> <Pine.LNX.4.58L.0412161501190.15472@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0412161501190.15472@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Maciej W. Rozycki <macro@linux-mips.org> wrote:

> On Thu, 16 Dec 2004, Ingo Molnar wrote:
> 
> > c0125ee9:     1529 	fa                   	cli    
> >                  ^---------------------------------- # of profiler hits
> > c0125eea:      507 	fb                   	sti    
> > c0125eeb:        0 	fa                   	cli    
> > c0125eec:     3719 	fb                   	sti    
> > c0125eed:        0 	fa                   	cli    
> > c0125eee:     1579 	fb                   	sti    
> > c0125eef:        0 	fa                   	cli    
> > c0125ef0:     3317 	fb                   	sti    
> > c0125ef1:        0 	fa                   	cli    
> > c0125ef2:     3030 	fb                   	sti    
> > c0125ef3:        0 	fa                   	cli    
> > c0125ef4:     2497 	fa                   	cli    
> > c0125ef5:     1055 	fb                   	sti    
> > c0125ef6:        0 	fa                   	cli    
> [...]
> > the 'cli' is always a 'black hole' to the NMI, while the second of two
> > consecutive cli's are not.
> 
>  It looks like the 'sti' is actually the black hole -- remember
> interrupts are traps, that is they are probed for and taken after
> instruction execution.

The 'sti' "shadows" the cli, i.e. we'll never get an interrupt that gets
inbetween 'sti;cli'. I.e. sti is the black-hole generator, and 'cli' is
in the black hole. In that sense the 'cli' is in a black hole to the
NMI: the NMI will never see cli as the 'next to be executed'
instruction.

	Ingo

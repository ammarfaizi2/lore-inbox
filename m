Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbSLNL4K>; Sat, 14 Dec 2002 06:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267603AbSLNL4J>; Sat, 14 Dec 2002 06:56:09 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:61959 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267602AbSLNL4J>; Sat, 14 Dec 2002 06:56:09 -0500
Message-Id: <200212141157.gBEBvFs02981@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Date: Sat, 14 Dec 2002 16:46:41 +0000
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Egger <degger@fhm.edu>, Dave Jones <davej@codemonkey.org.uk>,
       Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua> <20021212180957.GA184@elf.ucw.cz>
In-Reply-To: <20021212180957.GA184@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 December 2002 18:09, Pavel Machek wrote:
> Hi!
>
> > > > I believe someone (Jeff Garzik?) benchmarked gcc code
> > > > generation, and the C3 executed code scheduled for a 486 faster
> > > > than it did for -m586
> > > > I'm not sure about the alignment flags. I've been meaning to
> > > > look into that myself...
> > >
> > > Interesting. I have no clue about which C3 you're talking about
> > > here but a VIA Ezra has all 686 instructions including cmov and
> > > thus optimising for PPro works best for me.
> > >
> > > Prolly I would have to do more benchmarking to find out about
> > > aligment advantages.
> >
> > I heard cmovs are microcoded in Centaurs.
> >
> > s...l...o...w...
>
> It still might be faster then a branch... or not if centaurs are
> really that simple.
> 								Pavel

I did not measure it myself, but rumors were they took tens of cycles.

Well, a IFcc prefix meaning 'execute next instruction if' would be
way more cool that CMOVcc. Because I want CADDcc, CTESTcc, CBSWAPcc too ;)

But since all 1 byte opcodes are taken and

	Jcc	skip		# <- 2 byte opcode
	opcode	op1,op2
skip:

I think some CPU magic can detect such short jumps and handle'em just like
they were such a prefix, saving potential branch (mis-)prediction.
--
vda

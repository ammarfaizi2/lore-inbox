Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSLKOZj>; Wed, 11 Dec 2002 09:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSLKOZj>; Wed, 11 Dec 2002 09:25:39 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:65284 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267162AbSLKOZi>; Wed, 11 Dec 2002 09:25:38 -0500
Message-Id: <200212111419.gBBEJua06684@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Date: Wed, 11 Dec 2002 17:09:34 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Egger <degger@fhm.edu>, Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua> <20021211105808.GA17354@codemonkey.org.uk>
In-Reply-To: <20021211105808.GA17354@codemonkey.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 December 2002 08:58, Dave Jones wrote:
> On Wed, Dec 11, 2002 at 11:19:23AM -0200, Denis Vlasenko wrote:
>  > > Prolly I would have to do more benchmarking to find out about
>  > > aligment advantages.
>  >
>  > I heard cmovs are microcoded in Centaurs.
>  > s...l...o...w...
>
> Hardly surprising given that the chip isn't targetted at the
> performance market.

*We Support 686 Instruction Set* plastered everywhere? ;)
Who cares that a single cmov take some tens of cycles...
(btw, can someone measure that? I have no C3...)

On 7 July 2002 12:32, Willy TARREAU wrote:
> because GCC's output is really ugly. In fact, it is
> also ugly when it generates cmov. I disassembled my
> libc and found that it subobtimizes the code at the
> point that it's far worse with cmov than without !
> (more instructions, more memory accesses, more
> registers used).

Do not try to optimize "pedal to the metal" without
actually looking at the results.
With "-march=i686" on C3 one will get:

* Non-optimal GCC code generation
* Really Slow (tm) cmovs
* Buggy code (cmov with mem operands)
  if one don't think above two are not enough ;)

On 10 December 2002 05:22, Daniel Egger wrote:
> Am Die, 2002-12-10 um 06.52 schrieb Dave Jones:
> > I believe someone (Jeff Garzik?) benchmarked gcc code generation,
> > and the C3 executed code scheduled for a 486 faster than it did for
> > -m586
> > I'm not sure about the alignment flags. I've been meaning to look
> > into that myself...
>
> Interesting. I have no clue about which C3 you're talking about here
> but a VIA Ezra has all 686 instructions including cmov and thus
> optimising for PPro works best for me.

Such things need testing. A kernel compile would suffice I guess.
--
vda

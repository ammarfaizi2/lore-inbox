Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSKXMAN>; Sun, 24 Nov 2002 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSKXMAN>; Sun, 24 Nov 2002 07:00:13 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50695 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266330AbSKXMAL>; Sun, 24 Nov 2002 07:00:11 -0500
Message-Id: <200211241201.gAOC1lp05914@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: P4 compile options
Date: Sun, 24 Nov 2002 14:52:28 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121210830.00b58890@mail.dns-host.com> <200211221013.gAMADpp31088@Port.imtp.ilyichevsk.odessa.ua> <20021122105438.GA16662@suse.de>
In-Reply-To: <20021122105438.GA16662@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 November 2002 08:54, Dave Jones wrote:
> On Fri, Nov 22, 2002 at 01:04:39PM -0200, Denis Vlasenko wrote:
>  > I consider 16-byte code alignment as way too big.
>  > P4 zealots can demand even more I guess :(
>  > I will happily change my mind when/if I'll see
>  > favorable speed/kernel size benchmarks. Until then,
>
> I think there's a misunderstanding here.
> The march=pentium4 option is only used when you select
> "build me a pentium 4 kernel" You do realise that right?
> Generic kernels don't change 1 bit.
>
>  > I think 4-byte alignment is closest to sanity.
>
> You know where to find the Intel P4 optimisation manuals..
>
>  > Not exactly P4 related but: if you tell gcc your
>  > processor has cmov, gcc will try to use it.
>
> So what ? Show me a P4 without cmov.
>
>  > Results:
>  > * gcc code is worse with cmov than without
>  > * some CPUs (Cyrix?) have slow cmovs (microcoded?)
>  > * you lose whenever you try to use your code
>  >   on cmov-less CPU.
>
>   <------------ The point.
>                               --------------> You.


I find it's far too easy for me to talk on lkml than
to do something useful... I'll try to *not* reply next time :)

Let's start from the start.
This is an original message which started this thread:

On 21 November 2002 18:18, Margit Schubert-While wrote:
> Maybe a dumb question -
> Is it possible to use the "-march=pentium4 -mfpmath=sse -msse2"
> options for a P4 ?
> I notice anything over a P2 just gets "-march=i686".

It sounds like: "I've got a P4, I want my kernel use each and every P4ism
possible. I want. I want. I want.  How to do it?" (a bit exagerrated :)

An important question is missing here: is a particular P4ism useful?
It is ok to use P4isms *if* one is sure they lead to better kernel.

What -mfpmath=sse or -msse2 will give us? Probably nothing since kernel
do not use fp (well, almost). And if it would use 'em, use of sse2 can
*slow down* context switch. I'm not sure, but _it needs testing_ before
we "optimize" kernel with such options.

Margit Schubert-While <margitsw@t-online.de> has an excellent opportunity
to compile a handful of kernels, run, say, contest with them and report
his findings. ;)
--
vda

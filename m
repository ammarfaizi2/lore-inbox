Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVJRKiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVJRKiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 06:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJRKiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 06:38:51 -0400
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:15233 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750785AbVJRKiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 06:38:50 -0400
Date: Tue, 18 Oct 2005 11:38:39 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Ben Dooks <ben@fluff.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark __init code noinline to stop erroneous inclusions
Message-ID: <20051018103839.GA32720@home.fluff.org>
References: <20051017213737.GA18686@home.fluff.org> <2cd57c900510171803i7b6ccfffwffb378b535f10558@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900510171803i7b6ccfffwffb378b535f10558@mail.gmail.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 09:03:20AM +0800, Coywolf Qi Hunt wrote:
> On 10/18/05, Ben Dooks <ben@fluff.org.uk> wrote:
> > Make __init also have the noinline attribute attached
> > to it, to stop code marked as __init being included
> > into non __init code. This not only wastes space, but
> > also makes it impossible to track down any calls from
> > non-init code as differing compilers and optimisations
> > make differing decisions on what to inline.
> 
> I think this is overkill. __init code could be inlined into __init
> code.  Instead we should make sure to not to call __init code from
> non-init code `directly'.

This is very difficult to detect when the compiler is inlining the
function code. 
 
> It is a gcc bug. Gcc really should respects __attribute__
> ((__section__ (".init.text"))), and not inline the code in that
> section.


>From the gcc 4.0 manual,
http://gcc.gnu.org/onlinedocs/gcc-4.0.0/gcc/Function-Attributes.html

section ("section-name")
    Normally, the compiler places the code it generates in the
    text section. Sometimes, however, you need additional sections,
    or you need certain particular functions to appear in special sections.
    The section attribute specifies that a function lives in a particular
    section.

My reading of the passage is that the output code will be put in
the specified section. It does not say wether or not the compiler
is allowed to do any other optimisations it sees fit on the data.

My belief is that the compiler should be able to do this form of
optimisation, unless we tell it otherwise. The only harm is that
it makes it difficult to detect errors from compilers that do not
do it.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRCZOwM>; Mon, 26 Mar 2001 09:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRCZOvv>; Mon, 26 Mar 2001 09:51:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12523 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131307AbRCZOvj>;
	Mon, 26 Mar 2001 09:51:39 -0500
Message-ID: <3ABF574D.65CBD22@mandrakesoft.com>
Date: Mon, 26 Mar 2001 09:50:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net, cort@fsmlabs.com
Subject: Re: CML1 cleanup patch, take 2
In-Reply-To: <200103260955.f2Q9tfo14568@snark.thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

esr wrote:
> OK, since peoples' territorial instincts have started to lather up,
> I guess I'm going to have to do this the hard way...

"Split up your patch" still apparently hasn't filtered into your head. 
Since that is more difficult than posting a single patch, I would say
you are doing it the slack way, and the way that makes it more difficult
for Linus and Alan to approve one part of your patch, and disapprove of
another part.


> This file is a patch expressed in two ways.  First, procedurally, as a
> way to duplicate its effects on any kernel source tree.  Secondly, as
> an explicit patch against 2.4.3-pre8.  It replaces my previous patch
> against 2.4.3-pre6.
> 
> This patch is the first result of a consistency audit of the configuration 
> system.  I have been building analysis tools to check the correctness of
> my CML2 rules file, and the processs of testing them turned up some problems.
> 
> The purpose of this patch is threefold:
> 
> (1) Clean up two errors in the CML1 corpus that could lead to subtle bugs.
>     This is a BUG FIX in CML1.

separate patch?


> (2) Fix up 20 cris-architecture configuration symbols lacking a CONFIG_
>     prefix, so they obey CML1/CML2 conventions and can be detected by
>     `make dep', also static-analysis tools and consistency checkers.
>     This is a BUG FIX in CML1.

separate patch?

What did the cris guys say, when you showed them this patch?

I agree this change is a bug fix, but get the cris' guys input first.

This should be in a separate patch, too.


> (3) Fix up 10 configuration symbols of the form CONFIG_[0-9]*; specific 
>     changes are those suggested 8 Jan 2001 by PPC port maintainer Tom Rini.
>     This change has been APPROVED by an authorized maintainer.

Maybe I am not caught up with the times...  I thought Cort Dougan was
the overall PowerPC maintainer.  That's what MAINTAINERS says.

Anyway, this is up to the PowerPC guys, but I disagree with this change
nonetheless.  MandrakeSoft has a PPC port, and as I mentioned earlier,
some utilities in the build process etc. look at CONFIG_xxx.

PPC guys:  this is a gratuitous renaming change that is not required. 
If you have been following the "CML1 cleanup patch" thread, you see that
Eric is blindly dictating policy when he says that CONFIG_[0-9] needs to
be cleaned up.


> This leaves ten symbols in a form that breaks CML2.  I'll go after
> the other individual maintainers about those.  Sigh....
> 
> No actual object code will be changed by this patch; it merely does
> one-to-one substitutions on some configuration symbols.
> 
> Let me repeat that.  This patch changes *no* object code.  None.
> However, merging it before the 2.5 fork will save me (and probably
> Alan) some nasty large headaches later on...

Object code changes are not the only thing we are concerned with in a
stable series.
Let me repeat myself for the cheap seats:   Changing the 2.4.x
CONFIG_xxx namespace changes the source code API provided to other
kernel code.  It affects software not in the Linux kernel tree.

Your changes (1) and (2) sound ok.  Your change (3) is gratuitous, based
on policy change discussed with no one, and does not belong in stable
series 2.4.x.

Linus, Alan, Cort, please consider rejecting Eric's patch while it
contains (3).

Thanks,

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.

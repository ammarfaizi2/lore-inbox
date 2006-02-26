Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWBZR34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWBZR34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWBZR34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:29:56 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:44892 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751340AbWBZR3z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:29:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DcoUnDVHqPE2U+wYwhfaPTxnpbzIOy1yMVA38aE/Ti12yrcc6fnjYOCnItwJgWac3Pn3XC/jE/Wve4vJzIYPt6BJPsgqt0Yf7BZ01ZZeDowCCiBCXqLSNVaSVQqNDGv/eDLMW0vbntJ8MGiIVa9lKUaeWOfxtJ5SnEccWA784a0=
Message-ID: <9a8748490602260929v74fd8358r8bdb2d670508bb0a@mail.gmail.com>
Date: Sun, 26 Feb 2006 18:29:54 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <20060226170038.GF3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <20060226170038.GF3674@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Feb 26, 2006 at 05:21:17PM +0100, Jesper Juhl wrote:
> >
> > Hi everyone,
>
> Hi Jesper,
>
> > I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
> >
> >       95 kernels were build with 'make randconfig'.
> >       1 kernel was build with the config I normally use for my own box.
> >       1 kernel was build from 'make defconfig'.
> >       1 kernel was build from 'make allmodconfig'.
> >       1 kernel was build from 'make allnoconfig'.
> >       1 kernel was build from 'make allyesconfig'.
> >
> > That was an interresting experience.
> >
> > First of all not very many of the kernels actually build correctly and
> > secondly, if I grep the build logs for warnings I'm swamped.
> >
> > Out of 100 kernels 82 failed to build - that's an 18% success rate people,
> > not very impressive.
> >
> > Some of the failed builds are due to things like CONFIG_STANDALONE that
> > will break the build if not set to Y (unless you have the firmware
> > available ofcourse), but looking at the config files I find that only 26
> > kernels have CONFIG_STANDALONE unset, so that only accounts for a quarter
> > of the kernels.
> >
> > A lot of failed builds are due to invalid combinations of some stuff
> > being build-in and some stuff being build as modules.
> > This, as far as I'm concerned, is something that the dependencies in
> > Kconfig should make impossible - hence my conclusion that we suck at deps.
>
> Yes, it should be fixed.
>
> Our dependencies are usually relatively good in all the normal cases.

Agreed, most common configs don't spew too many warnings, but that
doesn't mean the warnings for the uncommon cases shouldn't be fixed.


> I'd expect e.g. half of your randconfig builds to have EMBEDDED=y set,

you are dead on :

$ grep "EMBEDDED=y" *.config | wc -l
50


> and this often exposes problems. They should be fixed, but it is far
> from the .config's most users use.
>
> And then there's the usual problem with numbers, e.g. each of
> CONFIG_STANDALONE=n or breakage of the OSS sonicvibes driver will
> account for a two digit number of build failures. I'd guess fixing two
> or three problems will bring your 18% number > 50%.
>

Let's get to work then :)

Actually I already send a few patches for a few errors and I plan to
send many more.


> > >From 100 kernel builds there was a total of 16152 warnings and 645 of those
> > are unique warnings, the rest are duplicates.
> >
> > We are drowning in warnings people. Sure, many of the warnings are due to
> > gcc getting something wrong and shouldn't really be emitted, but a lot of
> > them point to actual problems or deficiencies (I obviously haven't looked
> > at them all in detail yet, so take that with a grain of salt please).
> >...
>
> It's well-known that BROKEN_ON_SMP drivers often spit 50 warnings in one
> warning. If you remove the dozen worst drivers the numbers should look
> much better.
>
Better yet, let's fix the warnings.


> Not that our current situation was perfect, but the number of warnings
> in .config's people usually use isn't that bad.
>

I agree it's not too bad for most people. The point of my post was
mostly a "call to arms" trying to get people interrested in fixing all
the warnings and build errors we have.
There's a lot of focus on implementing new features - and that's great
- but there's little emphasis on fixing the problems we have and
already know about - I'd like to see that change, and my post was
mainly an attempt at making that happen :)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

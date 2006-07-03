Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWGCNHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWGCNHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWGCNHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:07:31 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:3968 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751101AbWGCNHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:07:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gN4y4hc83++RDtMyrwn8QCB186okbGhZaDmz/DvenlCo7wFtzA4TXbKueWsz1Ou/dGZQ5952I7SBuBCSx7GoXAdwfgT19H5SxQNB1MR+/BBFkHXf01koMOWAUCCGfJk5US/GzG8vKN5htqysQxOdxFruoV3CG3BOy3zen2Y0xTI=
Message-ID: <a44ae5cd0607030607y290edaa9ud492eb819d383329@mail.gmail.com>
Date: Mon, 3 Jul 2006 06:07:29 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060703051723.GA13415@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
	 <1151826131.3111.5.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>
	 <20060703051723.GA13415@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Miles Lane <miles.lane@gmail.com> wrote:
>
> > >If Ubuntu patched gcc rather than just putting it in the build
> > >environment... then you should switch to a less braindead distribution
> > >really ;)
>
> > Well, from the web page referenced at the top of this message, you can
> > see that they are already aware of these issues:
> >
> > Cons:
> >    *      It breaks current upstream kernel builds and potentially
> > other direct usages of gcc. Kernel is by far the most important use
> > case. Upstream should change the default options to build with
> > -fno-stack-protector by default.
> >    *      It is not conformant to upstream gcc behaviour.
>
> i think the only sane way for a generic distro to introduce an intrusive
> security feature is a 3-phase process:
>
>  #1 - introduce the new security option
>  #2 - increase use of it gradually, map all the exceptions on the way
>  #3 - once exceptions are mapped widely enough, switch the option to
>       default-on
>
> this makes the introduction of security seemless/gradual to
> users/developers, without compromising on the end goal of having the
> security feature on by default.
>
> Ubuntu seems to have opted to go to phase #3 directly, which is no doubt
> quite brutal but it's their choice. In any case, whichever methodology
> is used the kernel got flagged as an "exception" and we should help this
> security effort and change the kernel: i.e. lets apply the
> -fno-stack-protector flag to the kernel build.

Well, I see that Andrew has accepted (mm5)
the -fno-stack-protector patch for the Makefile, but klibc remains
unpatched (scripts/Kbuild.klibc and usr/klibc/arch/i386/MCONFIG).
Would the right person in this dialog submit those changes to Andrew?

Many thanks,
        Miles

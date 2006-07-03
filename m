Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWGCFWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWGCFWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 01:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWGCFWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 01:22:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11419 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750733AbWGCFWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 01:22:04 -0400
Date: Mon, 3 Jul 2006 07:17:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Message-ID: <20060703051723.GA13415@elte.hu>
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <1151826131.3111.5.camel@laptopd505.fenrus.org> <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Miles Lane <miles.lane@gmail.com> wrote:

> >If Ubuntu patched gcc rather than just putting it in the build
> >environment... then you should switch to a less braindead distribution
> >really ;)

> Well, from the web page referenced at the top of this message, you can 
> see that they are already aware of these issues:
> 
> Cons:
>    *      It breaks current upstream kernel builds and potentially
> other direct usages of gcc. Kernel is by far the most important use
> case. Upstream should change the default options to build with
> -fno-stack-protector by default.
>    *      It is not conformant to upstream gcc behaviour.

i think the only sane way for a generic distro to introduce an intrusive 
security feature is a 3-phase process:

 #1 - introduce the new security option
 #2 - increase use of it gradually, map all the exceptions on the way 
 #3 - once exceptions are mapped widely enough, switch the option to 
      default-on

this makes the introduction of security seemless/gradual to 
users/developers, without compromising on the end goal of having the 
security feature on by default.

Ubuntu seems to have opted to go to phase #3 directly, which is no doubt 
quite brutal but it's their choice. In any case, whichever methodology 
is used the kernel got flagged as an "exception" and we should help this 
security effort and change the kernel: i.e. lets apply the 
-fno-stack-protector flag to the kernel build.

	Ingo

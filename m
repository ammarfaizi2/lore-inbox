Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVL3Ati@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVL3Ati (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVL3Ati
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:49:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751171AbVL3Ath (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:49:37 -0500
Date: Thu, 29 Dec 2005 16:49:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ryan Anderson <ryan@michonline.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
In-Reply-To: <43B48176.3080509@michonline.com>
Message-ID: <Pine.LNX.4.64.0512291643280.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
 <43B48176.3080509@michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Ryan Anderson wrote:
> 
> This, for what it's worth, is the same breakage that Dave seemed to be
> most frustrated with during his OLS keynote, regarding ALSA versions,
> and a few other things that caused breakage and the user space failed to
> work correctly when the kernel was reverted.  (I hope I'm not putting
> words in your mouth, Dave).

I agree: the worst part of version dependency is that it's really hard in 
general to just move one of the components backwards or forwards. 
Something you want to do when breakage occurs, or just because you need to 
figure out some _other_ problem (like doing a kernel bug bisection).

Which is why pretty much _every_ component needs to be backwards 
compatible at least to some degree. Otherwise they'd need to be bundled 
and developed together as one thing.

IOW, the same way it's wrong for the kernel to need new binaries, it's 
wrong for binaries to need a new kernel. It's one reason why we seldom add 
new system calls: they aren't all that useful in any kind of short 
timeframe, because even programs that would _like_ to use them usually 
can't do so for a long time (until they don't have to worry about people 
running old kernels any more).

(Some system calls are easier to add than others - if you can easily 
emulate the new system call semantics with just a slight performance hit, 
you can just have a simple wrapper with a fallback. That doesn't always 
work well - some things are just very hard to emulate efficiently).

		Linus

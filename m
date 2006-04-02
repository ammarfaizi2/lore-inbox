Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWDBR76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWDBR76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWDBR76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 13:59:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43784 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932403AbWDBR75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 13:59:57 -0400
Date: Sun, 2 Apr 2006 19:58:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Message-ID: <20060402175859.GA9839@mars.ravnborg.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 06:52:05AM -0500, Kyle Moffett wrote:
> On Fri, 24 Mar 2006 17:46:27 -0500 Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > I'm working on some sample patches now which I'll try to post in a
> > few days if I get the time.
> 
> Ok, here's a sample of the KABI conversion and cleanup patches that I'm
> proposing.  I have a few fundamental goals for these patches:
> 1)  The Linux kernel compiles and works at every step along the way
> 2)  Since most of the headers are currently quite broken with respect to
>     GLIBC and userspace, I won't spend much extra time preserving
>     compatibility with GLIBC, userspace, or non-GCC compilers.
> 3)  Everything in include/kabi will have a __kabi_ or __KABI_ prefix.
> 4)  Headers in include/linux that need the KABI interfaces will include
>     the corresponding <kabi/*.h> header and define or typedef the
>     necessary KABI definitions to the names the kernel wants.
> 5)  The stuff in include/kabi/*.h should always be completely independent
>     of userspace/kernelspace and not require any includes outside of
>     <kabi/*>.  This means that the only preprocessor symbols that we can
>     assume are present are those provided by the compiler itself.
Hi Kyle.
Been watching this thread evolve for a while - and contributed a little
myself.
But I fail to find a rationale for the selected approach.

There are at minimum the following options:
1) Go through current set of headers and sanitize them - using
   __KERNEL__ to identify kernel only stuff.
2) Keep user space interface (KABI in your term?) in include/ and slowly
   move kernel specific definitions somewhere else. This has the great
   advantage to keep backward compaitibility.
3) 'Preprocess' include/ and generate a set of KABI files based on
   current set of (cleaned up) kernel header files.
   'Preporcess in '' because a C-preprocessor will not be sutilable.
4) Introduce a virgin KABI (your approach). The virgin KABI has no users
   today and does in no way preserve backward compatibility.

Can you try to explain why the virgin approach is superior to the
others.

	Sam

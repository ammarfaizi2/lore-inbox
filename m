Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTESW4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTESW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:56:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32609 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263350AbTESW4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:56:14 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 May 2003 17:05:20 -0600
In-Reply-To: <3EC95B58.7080807@zytor.com>
Message-ID: <m18yt235cf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > 
> > ABI changes or ABI additions?
> > 
> > If the ABI is not fixed that is a bug.  Admittedly some interfaces
> > in the development kernel are still under development and so have not
> > stabilized on an ABI but that is a different issue.
> > 
> 
> ABI fixes and ABI additions, as well as outright ABI changes (yes they
> suck, but they happen.)

And ABI changes from the ABI exposed by a stable kernel are _B_U_G_S.
Yes _b_u_g_s happen but they are still _b_u_g_s.

It is legal to stop supporting an interface but changing the interface
in such a way that you must know the version of the kernel you are
running on is a _b_u_g.

> >>ABI headers is the only realistic solution.  We
> >>can't realistically get real ABI headers for 2.5, so please don't just
> >>break things randomly until then.
> > 
> > As the ABI remains fixed I remain unconvinced.  Multiple implementations
> > against the same ABI should be possible.  The real question which is the
> > more scalable way to do the code.
> 
> The ABI doesn't remain fixed.  Like everything else it evolves.

I meant to say the existing subset of the ABI, remains fixed.
Evolution by accretion is fine.

> > What I find truly puzzling is that after years glibc still needs
> > kernel headers at all.
> 
> What I find truly puzzling is that obviously intelligent people like
> yourself still seem to think that ABIs remain fixed.

Simply because if the existing subset of an ABI does not remain fixed
it is a _b_u_g.  Only once in a blue moon is there a chance for
an incompatible change, like when switching to x86-64.

And given my experiences running old a.out binaries Linux does a pretty good
job at this.  And I am not willing to admit that changes that
break backwards compatibility (except for applications that depended
on implementation bugs) are anything except bugs.  That would only
encourage changes that should not happen.

I do agree however that the ABI should be better documented.  And that
being able to automatically generate headers from the official
documentation would be advantageous.  With good documentation it
should actually be harder to change an ABI because what the old ABI
was will be clearer.

And I do agree that if the kernel builds with headers automatically
generated from the official documentation.  Then it will be easy
to guarantee they are in sync.

But there is no reason not to write documentation today about what the
kernel interfaces are and convert glibc and the kernel later when
it is convenient to their development cycles.  

What I do not is see the necessity of using automation to follow the
documentation.

Eric

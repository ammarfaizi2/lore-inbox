Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbRERQEd>; Fri, 18 May 2001 12:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbRERQEP>; Fri, 18 May 2001 12:04:15 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:30217 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S262360AbRERQEC>; Fri, 18 May 2001 12:04:02 -0400
Date: Fri, 18 May 2001 18:02:16 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010518105353.A13684@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0105181751050.5809-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Eric S. Raymond wrote:

> That being the case, we do face a question of design
> philosophy, expressed as a policy question about how to design
> rulesets.  Actually two questions:
>
> 1. When we have a platform symbol for a reference design like MVME147, do
>    we stick to its spec sheet or consider it representative of all derivatives
>    (which may have other facilities)?
>
> I know my answer to this one, which I will implement unless there's
> strong consensus otherwise.  I go for explicitness.  If we're going to
> support MVME147 derivatives and variants in the ruleset, they get
> their own platform symbols.

I believe it's important two distinguish between two things here,
auto-configuration and normal configuration.

One should take care to not mix these things up. Of course I don't know
about the specific hardware there, but I believe selecting NVME147 will
give you arch specific code which will cope with general aspects of that
board, but also for derived designs. That makes sense, and no need to
introduce different config symbols at that level.
I'd call CONFIG symbols like that basic, and they should be described by a
ruleset which ensures that building the kernel will actually work, and
that you have a chance that it even runs. (Things like a SCSI driver
requires the SCSI midlayer, etc. which would normally lead to unresolved
symbols or the inability to load the driver module into the running kernel
later).

On the other hand, for some people it would be nice to say I've got the
reference board, build the right kernel. That's okay, but it should be
another option, and rules like that should be in a separate files, so they
don't clutter up the "basic" rulesets.

So, leave the flexibility to people who need, and on top of that you can
have a mechanism which allows easier configuration for people who don't
want to care about the details.

However, more important there would be some option like "build me a kernel
for the hardware I'm currently running on" (and let the user fine tune
afterwards).

--Kai


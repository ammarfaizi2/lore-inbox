Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136159AbRECHgL>; Thu, 3 May 2001 03:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbRECHf6>; Thu, 3 May 2001 03:35:58 -0400
Received: from fungus.teststation.com ([212.32.186.211]:21646 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S136159AbRECHfo>; Thu, 3 May 2001 03:35:44 -0400
Date: Thu, 3 May 2001 09:34:20 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: John Stoffel <stoffel@casc.com>, <cate@dplanet.ch>,
        Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: Hierarchy doesn't solve the problem
In-Reply-To: <20010503030431.A25141@thyrsus.com>
Message-ID: <Pine.LNX.4.30.0105030907470.28400-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Eric S. Raymond wrote:

> In many cases there is no way to define "upper" or "lower".  (X86 and
> SMP) implies RTC!=n is actually a good example.  Here's where they fit
> in the tree:
> 
>  main                   'Linux Kernel Configuration System'
>      arch               'Processor type'
>          X86            'Intel or compatible 80x86 processor'
>      generic            'Architecture-independent feature selections'
>          SMP            'Symmetric Multi-Processing support'
>      archihacks         'Architecture-specific hardware hacks'
>          RTC            'Enhanced Real Time Clock Support'
> 
> Yes, that's right -- they're all at the same level.  OK, X86 is frozen
> by hypothesis.  So now give me a rule for telling which of SMP and RTC
> is "superior".  Note that in order to make the rule usable by the
> deducer, it can't know anything about the semantics of the symbols.

Doesn't 'make config' still ask the user about config options one-by-one?
(If not you can ignore the rest of this, I'd test it but I don't have time
 to mess with python2 right now).

Then it must somehow handle me trying to (incorrectly) answer X86=Y,
SMP=Y, RTC=N in some order?

The old oldconfig uses the existing .config as default answers, not as
initial state (right?). If an answer is missing or invalid then the user
gets a question. It never looks at all options at once. Doesn't that work
here?


When running make config I am guessing that this would happen:

The first symbol hit may be X86. The config-input has Y here, so it is
answered Y (I assume that is valid, otherwise do whatever the tty version
would normally do).

The second symbol would be SMP, the config-input says Y so it is set.
Since this requires RTC also I don't know what the tty version does, but
it must allow me to set it somehow.

The third symbol is RTC, the config-input has no defined value but it is
required by other settings so we ask. Possibly this is done automatically
right after setting SMP to Y.


There would be no 3^n problem as there is a defined order between the
symbols (whatever order 'make config' wants answers on an empty initial
state).

Perhaps I have missed something, but I really prefer the old oldconfig
over the new oldconfig.

/Urban


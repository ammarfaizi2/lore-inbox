Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129590AbQK2IRs>; Wed, 29 Nov 2000 03:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129595AbQK2IRi>; Wed, 29 Nov 2000 03:17:38 -0500
Received: from 62-6-231-191.btconnect.com ([62.6.231.191]:6148 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129590AbQK2IRd>;
        Wed, 29 Nov 2000 03:17:33 -0500
Date: Wed, 29 Nov 2000 07:48:55 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: David Hinds <dhinds@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
In-Reply-To: <20001128175348.J8881@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0011290744260.798-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Peter Samuelson wrote:
> [Tigran Aivazian]
> > First, they are not trivially equivalent. In fact, they are not
> > equivalent at all.  Any good C book should tell you that one places
> > data in "data segment" and another in "bss segment" (with a footnote
> > explaining historical meaning of "block started by symbol")
> 
> Do you have an ISO C standard to refer to?  I don't, but my guess is
> that the standard does not even *mention* discreet data sections.  It
> *does* say that globals and statics are implicitly initialized to 0 --
> the rest is a mere implementation issue.
> 
> So yes, the two statements *are* trivially equivalent, unless I'm wrong
> and the standard *does* talk about data sections.

no, I was not talking about ISO C standards but about the normal expected
C environment under any UNIX. I guess, we just mean different things by
"trivially equivalent" since neither of us said anything about what that
actually meant. What I meant by that was "not only imply the same logic
for the program but correspond to the same physical locations (if any) on
the resulting object file". In this sense, obviously, they are not
"trivially equivalent" since in one case  there is no physical location at
all -- that is the whole point of having bss at all.

> 
> > For example a programmer could expect the variable to be in .data for
> > binary patching the object
> 
> Binary patching?  If you are binary patching something you need to get
> the exact location, one way or another.  Whatever tool you use to
> extract the location of a symbol in an object file, that same tool
> should tell you which section it is in.  If the tool only looks in
> '.data', it is flawed.

Keith already pointed out why you are wrong there.

> 
>   [David Hinds]
> > > Did the savings really work out to be measured in kb's of space?  I
> > > would have expected compression to eliminate most of the savings.
> 
> Some boot targets are not compressed.  And the variables are scattered
> through the .data section rather than all in one place, so the 0s may
> not compress as well as you'd think.
> 
> Anyway, by some estimates 'vmlinux' has gone down by several kilobytes
> due to these patches.  Obviously the exact savings depend on .config .

"several" kilobytes? _My_ patches alone (accepted by Linus ages
ago) reduced it by >280K.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

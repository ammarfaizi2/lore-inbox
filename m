Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130537AbQK2AYi>; Tue, 28 Nov 2000 19:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131039AbQK2AY2>; Tue, 28 Nov 2000 19:24:28 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:49927 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S130537AbQK2AYU>; Tue, 28 Nov 2000 19:24:20 -0500
Date: Tue, 28 Nov 2000 17:53:48 -0600
To: Tigran Aivazian <tigran@veritas.com>
Cc: David Hinds <dhinds@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001128175348.J8881@wire.cadcamlab.org>
In-Reply-To: <20001128125840.A28888@valinux.com> <Pine.LNX.4.21.0011282101030.1940-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011282101030.1940-100000@penguin.homenet>; from tigran@veritas.com on Tue, Nov 28, 2000 at 09:08:13PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tigran Aivazian]
> First, they are not trivially equivalent. In fact, they are not
> equivalent at all.  Any good C book should tell you that one places
> data in "data segment" and another in "bss segment" (with a footnote
> explaining historical meaning of "block started by symbol")

Do you have an ISO C standard to refer to?  I don't, but my guess is
that the standard does not even *mention* discreet data sections.  It
*does* say that globals and statics are implicitly initialized to 0 --
the rest is a mere implementation issue.

So yes, the two statements *are* trivially equivalent, unless I'm wrong
and the standard *does* talk about data sections.

> For example a programmer could expect the variable to be in .data for
> binary patching the object

Binary patching?  If you are binary patching something you need to get
the exact location, one way or another.  Whatever tool you use to
extract the location of a symbol in an object file, that same tool
should tell you which section it is in.  If the tool only looks in
'.data', it is flawed.

  [David Hinds]
> > Did the savings really work out to be measured in kb's of space?  I
> > would have expected compression to eliminate most of the savings.

Some boot targets are not compressed.  And the variables are scattered
through the .data section rather than all in one place, so the 0s may
not compress as well as you'd think.

Anyway, by some estimates 'vmlinux' has gone down by several kilobytes
due to these patches.  Obviously the exact savings depend on .config .

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

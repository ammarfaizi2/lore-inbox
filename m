Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277197AbRJDRex>; Thu, 4 Oct 2001 13:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277198AbRJDRen>; Thu, 4 Oct 2001 13:34:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42291 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277197AbRJDReZ>; Thu, 4 Oct 2001 13:34:25 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Oct 2001 11:25:13 -0600
In-Reply-To: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
Message-ID: <m1hetfz5ae.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wow what a wild spin off of my stream of consciousness.

Linus Torvalds <torvalds@transmeta.com> writes:

> On 4 Oct 2001, Eric W. Biederman wrote:
> >
> > First what user space really wants is the MAP_COPY.  Which is
> > MAP_PRIVATE with the guarantee that they don't see anyone else's changes.
> 
> Which is a completely idiotic idea, and which is only just another example
> of how absolutely and stunningly _stupid_ Hurd is.

Well in this case it is Mach not Hurd, and I wouldn't be suprised if
you could find MAP_COPY in selected BSDs.  The semantics wanted are
very reasonable.  You only want to see your changes to a given file. 
In practice there is no reason that anyone needs to actually change
the file so MAP_PRIVATE | MAP_DENYWRITE is much more sensible (at
least implementation wise).

> The thing with MAP_COPY is that how do you efficiently _detect_ somebody
> elses changes on a page that you haven't even read in yet?

Definentily.

> Trust me. The people who came up with MAP_COPY were stupid. Really. It's
> an idiotic concept, and it's not worth implementing.

I quite agree that MAP_COPY is not worth implementing.  And I never
said otherwise.  I only mentioned so I could think what the
alternatives where and what it's benefits really were.

> And this all for what is a administration bug in the first place.

Probably.  I can't think of any other cases where this could trigger.

However I think is is sensible to export MAP_DENYWRITE to user space.
It cheaply closes the administration bug, it is partially exported
already, and can even allow dynamic loaders to follow the kernel
noexec policy.  

The latter looks like an actual advantage over MAP_COPY.  Though
somehow MAP_EXECUTABLE sounds like a better name...

Eric


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbTIJS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbTIJS4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:56:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18050 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265501AbTIJSzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:55:51 -0400
Date: Wed, 10 Sep 2003 14:58:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
In-Reply-To: <20030910183138.GA23783@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0309101439390.18459@chaos>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com>
 <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com>
 <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos>
 <20030910183138.GA23783@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > I would guess that the compiler output might be:
>
> Your guess is incorrect.
>
> > You are always going to take an extra jump in one execution
> > path after the function, and you will take a conditional jump
> > before the function call in the other execution path. So, you
> > always have the "extra" jumps, no matter.
>
> That is not true.  The "likely" path has no taken jumps.
>

Absolutely, positively, irrefutably wrong! Any logical operation
with any real processor can only result in a jump upon condition. The
path not taken will always require a jump around the code that
handled the jump upon condition unless the code exists at
the end of a procedure where a 'return' will suffice. Period. There
is discussion if you don't understand this. If you insist upon
taking exception to everything I say, without even reading what
I say, then you are wasting a lot of energy.

All real processors make jumps based upon the preceeding logical
operation, i.e., if equal, if less, if greater, if true. With
Intel, you have the following construct:
After the conditional test, everybody has to execute from label
more_code:



		cmpl	$1, %eax
		jz	1f
		jc	2f
		call	do_default
		jmp	more_code
	1:	call	do_something_if_equal
		jmp	more_code
	2:	call	do_something_if_less
	more_code:

In every case, one has to jump around code for other execution paths
except the last, where you have to jump on condition anyway. There
is no free liunch, and the straight-through route, do_default
uas just as many jumps as the last.


> Think about the code again.
> How would you optimise it, if you were writing assembly language yourself?
>

I did. And I do this for a living. And, after 30 years of this shit
they still haven't fired me. Learn something. I'm pissed.

> (In more complex examples, another factor is that mis-predicted
> conditional jumps are much slower than unconditional jumps, so it is
> good to favour the latter in the likely path).
>

Show me the money. With Intel, the testing of the condition, existing
in the flags, requires an instruction, unconditional or not.

> -- Jamie
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131954AbQKZCDD>; Sat, 25 Nov 2000 21:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131959AbQKZCCx>; Sat, 25 Nov 2000 21:02:53 -0500
Received: from hera.cwi.nl ([192.16.191.1]:41214 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131954AbQKZCCt>;
        Sat, 25 Nov 2000 21:02:49 -0500
Date: Sun, 26 Nov 2000 02:32:39 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: rmk@arm.linux.org.uk, rusty@linuxcare.com.au, linux-kernel@vger.kernel.org,
        Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126023239.B7049@veritas.com>
In-Reply-To: <20001125211939.A6883@veritas.com> <Pine.LNX.4.21.0011252205500.768-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011252205500.768-100000@penguin.homenet>; from tigran@veritas.com on Sat, Nov 25, 2000 at 10:27:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 10:27:15PM +0000, Tigran Aivazian wrote:
: Hello Andries,

Hi Tigran,

: ... I am quite free to _rely_ on this fact and will possibly do so.

Yes, you are. But some programmers have learned that it is a good
idea to code in a way that is informative to the programmer.

: > Tigran, you like to destabilize Linux.
: 
: Oh, Andries, that is insulting. Surely you do not really mean that.

No insult intended.
It is just that if there is an abyss somewhere, I like to stay at least
a meter away from it. Someone else may think that one inch suffices.
I see you propose a lot of changes that yield a negligable advantage
and reduce stability a tiny little bit. That is pushing Linux in the
direction of this abyss. You notice that the view gets better, and I
get nervous.

You seem to have these strange ideas. I quoted you

: It is better for code to be smaller than to be slightly more fool-proof.

Here is a different one:

: I think that the check for inode->i_op == NULL in various vfs_XXX()
: functions is bogus, i.e. if it is NULL then it must be a bug in
: some filesystem's ->read_inode() method and therefore, instead of
: returning error to userspace we should immediately panic, since
: it is a kernel bug.

Does the kernel contain a bug? Panic!  I don't think my alpha would
have gotten an uptime of 1198 days under that paradigm.
(I don't think you were serious, but still..)

  [I am not so sure why i_op == NULL necessarily is a bug.
  Sometimes a routine invents a dummy inode just because it is needed
  in some calling convention, while nothing of this inode is used
  except for example i_rdev. Maybe it does not occur today, in the
  filesystems in the 2.4 kernel tree. But such checks: test i_op,
  then test i_op->function, then call i_op->function() ensure
  a local correctness. That is what I like.
  Reading all filesystems in the kernel tree is what I don't like.
  And there are many filesystems not in the kernel tree.]

This is not to debate this particular case - it is Al's business.
This is just an example where you want to sacrifice local correctness
and be satisfied with global correctness.

: "sense of measure"

Yes, well formulated!

But this was a communication to linux-kernel, not an attack.
It was meant to say two things, namely
(i) Source code is a communication to programmers and to the compiler.
It is a bad idea to optimize the communication towards the compiler
when that is detrimental to the communication towards programmers.
And (ii) locally correct code is more stable than code that is only
globally correct.

For me these are truisms, but when Rusty complained about loss of
information lots of people did not seem to understand what could be meant.
I took you as my victim because you always seem to take the point
of view that the code must be perfect, never mind the programmers,
and that it is a good idea to save a few instructions, never mind
local correctness. (And also because your old remark quoted above
still required a reaction.)

No offense intended.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

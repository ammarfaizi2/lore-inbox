Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131916AbQL1V6p>; Thu, 28 Dec 2000 16:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbQL1V6h>; Thu, 28 Dec 2000 16:58:37 -0500
Received: from SMTP3.ANDREW.CMU.EDU ([128.2.10.83]:17805 "EHLO
	smtp3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S131916AbQL1V6c>; Thu, 28 Dec 2000 16:58:32 -0500
Date: Thu, 28 Dec 2000 16:28:01 -0500 (EST)
From: Ari Heitner <aheitner@andrew.cmu.edu>
Reply-To: Ari Heitner <aheitner@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: sharing text segments of all programs
Message-ID: <Pine.SOL.3.96L.1001228000737.3482B-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this has to be a dumb idea -- either it's way harder to implement than i think,
or it's just plain impossible. but i'm curious why it won't work.

So, if you fork, all the pages in both the child and the parent are marked COW. 
Since the text segment is read only, it'll never be written to; all forked
children of a given process image share their code. This makes for very
efficient operation in many cases. A program could concievably even communicate
with a running copy of itself, and fork off a new copy of the running version
rather than keeping multiple copies in memory (resulting in significant
savings). And of course shared libraries are shared.

The question is, why shouldn't it be possible to share the text segments of
*all* running programs? You'd just have to keep track of which running
processes have unmodified executables (actually, in solaris, modifying an
executable of a running program is a good way to crash the program, since it
only loads the parts of the executable as it needs them. from experience, if
you're writing a shell in solaris, you can't compile your shell from within
your shell :). If you start up another copy of an already-running program, you
share its text pages.

I know segmented memory models in some past OSs have permitted this sort of
thing (OS/2 comes to mind). But this isn't really a segmentation model. It's
just a "oh, all that stuff is already in memory, I'll just increase the
refcount on *that* copy rather than loading a whole new copy".

But i've got to be wrong. I just don't know why.





Cheers,

Ari Heitner

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

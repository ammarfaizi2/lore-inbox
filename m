Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154143-29165>; Sat, 5 Sep 1998 04:54:31 -0400
Received: from vidar.diku.dk ([130.225.96.249]:4492 "EHLO vidar.diku.dk" ident: "root") by vger.rutgers.edu with ESMTP id <154157-29165>; Sat, 5 Sep 1998 04:49:16 -0400
Date: Sat, 5 Sep 1998 13:06:29 +0200 (METDST)
Message-Id: <199809051106.NAA18386@tyr.diku.dk>
From: Morten Welinder <terra@diku.dk>
To: linux-kernel@vger.rutgers.edu
cc: allbery@kf8nh.apk.net
Subject: Re: Virtual Machines, JVM in kernel
Sender: owner-linux-kernel@vger.rutgers.edu


"Brandon S. Allbery KF8NH" <allbery@kf8nh.apk.net> writes:

> [...] given a chunk of C code with a
> proof attached, the proof is untrustworthy (in point of fact, it *lies* if
> it claims there are no buffer overflows, except in degenerate cases that
> only use scalar values --- but the packet itself is not a scalar).  You can
> verify that the proof doesn't work, probably, which would be good enough...
> except that (as noted) *no* purported proof will pass this because the
> desired condition is not provable.  So proof-carrying code isn't going to
> work here.

This is rubbish.  C programs, as well as programs in other languages,
can be proven correct and the proofs can be (machine) verified.  It is
only a matter of time, lots of time.

What you are claiming above is (essentially) that all C programs have
buffer overflow.  That obviously isn't true.  Programs can be *made*
safe by preceding all otherwise unsafe operations by syntactic checks
for bounds.  So you would guard all array access with checks that the
index was in the right range, and for all strcpy's you would verify
that the string length was less than the target buffer length.  This
is perfectly doable, but might require modification of the program
in question.  Programs written this way should be quite easy to prove
free of buffer overflows.

BACK ONTOPIC: code with proofs is interesting for the kernel in the
case of packet filters.  You can get very impressive performance that
way.  By a rule of thumb, the filtering time should decrease by an
order of magnitude.

Readings: George Necula's and Peter Lee's work on proof-carrying code
"http://www.cs.cmu.edu/~petel/papers/pcc/pcc.html".  For a proof of
an interpreter (not a Java interpreter in C, unfortunately), see
[shameless plug] my own Ph.D. thesis which might be found at
"http://www.diku.dk/students/terra/" [slow link].

Morten

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html

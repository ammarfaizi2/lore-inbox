Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQLBXtI>; Sat, 2 Dec 2000 18:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbQLBXs7>; Sat, 2 Dec 2000 18:48:59 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:40850 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130645AbQLBXsw>;
	Sat, 2 Dec 2000 18:48:52 -0500
Date: Sat, 2 Dec 2000 18:18:06 -0500
Message-Id: <200012022318.SAA17498@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: david@linux.com, linux-kernel@vger.kernel.org, vpnd@sunsite.auc.dk
In-Reply-To: Albert D. Cahalan's message of Sat, 2 Dec 2000 17:00:32 -0500
	(EST), <200012022200.eB2M0Wu473578@saturn.cs.uml.edu>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
   Date: 	Sat, 2 Dec 2000 17:00:32 -0500 (EST)

   > Any programmer who has evolved sufficiently from a scriptie
   > should take necessary precautions to check how much data was
   > transferred.  Those who don't..well, there is still tomorrow.

   Yeah, people write annoying little wrapper functions that
   bounce right back into the kernel until the job gets done.
   This is slow, it adds both source and object bloat, and it
   is a source of extra bugs. What a lovely API, eh?

Well, that's the Unix interface you.  I you don't like it, why don't you
become a Windows programmer and try your hand at the Win32 interface?  :-)

Seriously, doing something different for /dev/random compared to all
other read(2) calls is a bad idea; it will get people confused.  The
answer is whenever you call read(2), you must check the return values.
People who don't are waiting to get themselves into a lot of trouble,
particularly people who writing network programs.  The number of people
who assume that they can get an entire (variable-length) RPC packet by
doing a single read() call astounds me.  TCP doesn't provide message
boundaries, never did and never will.  The problem is that such program
will work on a LAN, and then blow up when you try using them across the
real Internet.

Secondly, the number of times that you end up going into a kernel is
relatively rare; I doubt you'd be able to notice a performance
difference in the real world using a real-world program.  As far as
source/object code bloat, well, how much space does a while loop take?
And I usyally write a helper function which takes care of the while
loop, checks for errors, calls read again if EINTR is returned, etc.

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

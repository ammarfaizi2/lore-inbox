Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbQLCPzr>; Sun, 3 Dec 2000 10:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130989AbQLCPz1>; Sun, 3 Dec 2000 10:55:27 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:37394 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130984AbQLCPzZ>; Sun, 3 Dec 2000 10:55:25 -0500
Date: Sun, 3 Dec 2000 17:32:31 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, david@linux.com,
        linux-kernel@vger.kernel.org, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <200012022318.SAA17498@tsx-prime.MIT.EDU>
Message-ID: <Pine.LNX.4.21.0012031730070.13254-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, that's the Unix interface you.  I you don't like it, why don't you
> become a Windows programmer and try your hand at the Win32 interface?  :-)
> 
> Seriously, doing something different for /dev/random compared to all
> other read(2) calls is a bad idea; it will get people confused.  The
> answer is whenever you call read(2), you must check the return values.
> People who don't are waiting to get themselves into a lot of trouble,
> particularly people who writing network programs.  The number of people
> who assume that they can get an entire (variable-length) RPC packet by
> doing a single read() call astounds me.  TCP doesn't provide message
> boundaries, never did and never will.  The problem is that such program
> will work on a LAN, and then blow up when you try using them across the
> real Internet.
> 
> Secondly, the number of times that you end up going into a kernel is
> relatively rare; I doubt you'd be able to notice a performance
> difference in the real world using a real-world program.  As far as
> source/object code bloat, well, how much space does a while loop take?
> And I usyally write a helper function which takes care of the while
> loop, checks for errors, calls read again if EINTR is returned, etc.

Agree. I thought that en exhausted entropy pool gave less random numbers
on the next read. After having a look at the source I realized I was
taking nonsense.
 
> 						- Ted


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

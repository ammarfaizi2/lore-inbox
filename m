Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310563AbSCGWkS>; Thu, 7 Mar 2002 17:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310559AbSCGWkJ>; Thu, 7 Mar 2002 17:40:09 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:17662 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S310553AbSCGWj6>; Thu, 7 Mar 2002 17:39:58 -0500
Newsgroups: comp.os.linux.development.system
Date: Thu, 7 Mar 2002 17:39:45 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
Cc: <kernelnewbies@nl.linux.org>
Subject: Accept -- still confused.
Message-ID: <Pine.NEB.4.33.0203071724310.875-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been trying to implement queuing and 'accept' in my protocol for few
weeks.
The way 'accept' should work is still not clear for me:
We have a socket s and we do the following in the server:
1. listen(s) -- thus s->sk_state = TCP_LISTEN.
2. accept(s) -- put a process into sleep.
...
3. receiving function gets an 'init' packet and looks for a socket which
matches packet's destination. The lookup returns s (!).
4. I put s on a queue (sk->tp_pinfo.af_tcp.accept_queue) and wake up the
process (why to put s itself on it's own queue?).
5. accept resumes, grabs first socket from the queue (s) and changes its'
state to TCP_ESTABLISHED and returns it to inet_accpet. (but this is the
same socket we've been listening on:( ).
6. inet_accept grafts s into a new socket(ok), but s is now in
TCP_ESTABLISHED state, instead of TCP_LISTEN, which ruins next connection.

How to keep the listening state and return the valid socket to
inet_accept, without messing with inet_accept itself?
My problem is the socket I am listening on and to which the 'init' packet
is destinated are the same.

Thanks for anything.
-marek



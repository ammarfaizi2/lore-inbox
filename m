Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280731AbRKJWIj>; Sat, 10 Nov 2001 17:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280732AbRKJWI3>; Sat, 10 Nov 2001 17:08:29 -0500
Received: from imsp.terry.uga.edu ([128.192.28.146]:54539 "EHLO
	ember.terry.uga.edu") by vger.kernel.org with ESMTP
	id <S280731AbRKJWIQ>; Sat, 10 Nov 2001 17:08:16 -0500
To: linux-kernel@vger.kernel.org (Linux kernel)
Subject: Re: test SYN cookies (was Re: SYN cookies security bugfix?)
In-Reply-To: <E161oM3-0007Xm-00@the-village.bc.nu>
	<m3y9lgkjnl.fsf@terry.uga.edu>
From: Ed L Cashin <ecashin@terry.uga.edu>
Date: 10 Nov 2001 17:04:47 -0500
Message-ID: <m34ro2ffk0.fsf@terry.uga.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed L Cashin <ecashin@terry.uga.edu> writes:

...
> What is a good way to test SYN cookies?  I can induce a three-second
> delay (on victim host V) before new TCP connections are accepted by
> sending a burst of 2000 SYN packets (from attacker A), where V is
> running a 2.2.14 or 2.2.17 kernel.  During the three seconds ICMP echo
> requests from A to V are being answered.
> 
> Turning on SYN cookies after /proc is mounted does not affect the
> three-second pause, though, so I figure that either the pause is not
> on account of a full half-open connection queue or SYN cookies are not
> working.

OK, I have found out that when I use three hosts to try to test SYN
cookies there is no pause, so the pause was a red herring.  However,
tests still seem to indicate that the SYN cookies feature doesn't do
anything. 

Host A sends a SYN flood to host B, now sporting a new 2.2.20 kernel
(with SYN cookie support, of course).  Host C makes repeated TCP
connections and ICMP echo requests to host B in order to monitor host
B.

However, even after setting tcp_max_syn_backlog to 1 on host B, I do
not observe any difference in connection times (from B to C) during a
SYN flood (from A to B) whether tcp_syncookies are on or off on host B
(1 or 0).  I am restarting the server on B each time I make an
adjustment in /proc.

Is there anyone who has any evidence that SYN cookies do anything in
kernel 2.2.x?  If so, how did you get that evidence, because I would
like to reproduce it.

-- 
--Ed Cashin                   PGP public key:
  ecashin@terry.uga.edu       http://www.terry.uga.edu/~ecashin/pgp/


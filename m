Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRJGQyU>; Sun, 7 Oct 2001 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276449AbRJGQyL>; Sun, 7 Oct 2001 12:54:11 -0400
Received: from [213.96.224.204] ([213.96.224.204]:29446 "EHLO manty.net")
	by vger.kernel.org with ESMTP id <S276448AbRJGQyA>;
	Sun, 7 Oct 2001 12:54:00 -0400
Date: Sun, 7 Oct 2001 18:54:27 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: 2.2 performance on high network load much much better than 2.4
Message-ID: <20011007185427.A2507@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was very concerned about the problems when machines are spammed, so I
started some tests comparing the different kernels and how they reacted to
this, I was astonished to see that 2.2.19 can cope very very well with those
spams while 2.4 is absolutely frozen under the same circunstances, so I was
wondering... how can this be, what has changed so much that now the
interrupts on a 2.4 kernel are so so so much slower than before like if they
were doing much more job? :-????

Well, this are some numbers I have noted down when comparing several
kernels...

The test consisted on doing a "time bunzip2 -t linux-2.4.9.bz2" noting the
time and the received network packets and overruns, during this time, in all
cases counter for errors, dropped or frame showed 0. The test takes 31
seconds if done without network load.

Spammed host:
CPU PIII at 868MHz
RAM 256MB
Chipset Via Apollo
NIC 3Com 905C 3c59x standard kernel driver

Spammers: P200MMX, and P166 with rtl8139 NICs using Simon Kirby's udpspam.
Network: 8 ports SVEC FD821 10/100Mb FD switch based on realtek chips.


Behaviour under 2.4.9ac18 kernel:

Time: 42 minutes 48 seconds
RX packets (aprox): 109 million overruns: 664

Interrupts as mesured by vmstat 1: from 6400 to 7700 (6500 average)


Behaviour under 2.4.10 kernel:

Time: 17 minutes 51 seconds
RX packets (aprox): 53.6 million overruns: 657

Interrupts as mesured by vmstat 1: from 6400 to 7700 (6500 average)


Behaviour under 2.2.19 kernel:

Time: 1 minute 8 seconds
RX packets (aprox): 3 million overruns: 81000

Interrupts as mesured by vmstat 1: from 35000 to 40000 (38500 average)

Note on the overruns on 2.2.19, they grow a lot when the first test is
carried, but if I continue to make tests they are much lower, in fact I even
added another spammer machine to the 2.2.19 test (dual P133) and I got this
results where you can see that the overruns are much much lower even though
the load was increased:

Time: 1 minute 17 seconds
RX packets (aprox): 4.3 million overruns: 476

Interrupts as mesured by vmstat 1: from 40000 to 44000 (43500 average)

One other thing that was seen on 2.2.19 and that did not appear on 2.4 was
that 2.2.19 said from time to time...

Too much work in interrupt, status e401.


I tried to spam 2.4.9ac18 with the same three machines I had used for the
last 2.2.19 test but the machine was almost totally frozen, after 6 hours of
test I stopped it.


So... is this a problem with 2.4 kernels that I'm the only one
experimenting?

Is there any explanation why 2.4 kernels are so bad on handling this
spamming while 2.2.19 does quite well?

If you need more data or want me to run any other tests, please tell me, but
send me expecific notes on what you want me to do.

Hope this helps finding what is happening with 2.4 kernels regarding to this
bad network behaviour.

Regards...
-- 
Manty/BestiaTester -> http://manty.net

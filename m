Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971703-26836>; Sun, 12 Jul 1998 05:38:27 -0400
Received: from val3-133.abo.wanadoo.fr ([193.252.196.133]:61764 "EHLO lw2l.bnc.interdrome.fr" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <971700-26836>; Sun, 12 Jul 1998 05:38:19 -0400
From: Andrew Derrick Balsa <andrebalsa@altern.org>
Reply-To: andrebalsa@altern.org
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] 2.0.34: new time.c code
Date: Sun, 12 Jul 1998 12:27:52 +0200
X-Mailer: KMail [version 0.7.9]
Content-Type: text/plain; charset=US-ASCII
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>, Colin Plumb <colin@nyx.net>, Rafael Reilova <rreilova@ececs.uc.edu>
MIME-Version: 1.0
Message-Id: <98071212534804.00441@lw2l.bnc.interdrome.fr>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

Hello,

Well, Scott having released his 2.1.10x code for "public consumption", here is a
2.0.34 version of the new time.c. Here is a summary of the new features:

 - Gettimeofday() is now twice as fast. Takes on average 420 ns on my Cyrix
6x86MX 166MHz chip, whereas the original code took > 1 us. This provides a neat
boost for code that calls gettimeofday() very often. Note that on very fast
machines one may now get non-unique timestamps. This may or may not be a
problem, testing needed.

- Is not affected by TSC stopping/slowing down. Works on all CPUs without need
of a workaround. Works with APM.

- drift and jitter-free calibration of the TSC (the joystick driver, for one,
could use this calibration data).

- The code is shorter and more elegant than the present implementation.

- Shows CPU MHz at boot time. Precision is better than 0.01%.

- Allows for a very simple implementation of NTP time adjustments. Colin Plumb
is working on code for that. Note that the new code does _not_ break or affect
in any way the present NTP code. It will just make it easier for future NTP
implementations.

- Extremely robust. I have been testing it for 45 days now without any problems.

The 2.0.34 version differs very slightly from the 2.1.10x implementation in the
way the TSC is calibrated, in order to get > 5x better precision.

Note that neither the 2.0.34 version nor the 2.1.10x version have been tested
on SMP machines. Could somebody with an SMP box test this, please?

Cheers,
---------------------
Andrew D. Balsa
andrebalsa@altern.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html

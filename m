Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVFVV1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVFVV1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVFVVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:23:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24270 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262529AbVFVVO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:14:26 -0400
Date: Wed, 22 Jun 2005 23:10:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622211037.GB24029@elte.hu>
References: <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu> <42B9C777.8040202@opersys.com> <20050622202242.GA17301@elte.hu> <42B9D208.4080305@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9D208.4080305@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Hmm... well, I can't say I'm uninterested. Any chances we can get a 
> copy of the scripts you use to do the MOAILT (Mother Of All Irq 
> Latency Tests).

my 'dohell' script is embarrasingly simple:

 while true; do dd if=/dev/zero of=bigfile bs=1024000 count=1024; done &
 while true; do killall hackbench; sleep 5; done &
 while true; do ./hackbench 20; done &
 ( cd ltp-full-20040707; su mingo -c ./run40; ) &
 ping -l 100000 -q -s 10 -f v &
 du / &
 ./dortc &

and i also start a preloaded flood-ping externally. ./dortc does:

 chrt -f 98 -p `pidof 'IRQ 8'`
 cd rtc_wakeup
 ./rtc_wakeup -f 8192 -t 100000

and ./run40 does:

 while true; do ./runalltests.sh -x 40; done

it's not rocket science - i'm just starting a sensible mix of latency 
generators, without letting any of them dominate the landscape.

> > [ I know the results i am seeing, but i wont 
> > post them as a counter-point because i'm obviously biased :-) I'll let 
> > people without an axe to grind do the measurements. ]
> 
> That's an extra reason for giving us a copy (or pointing us to one) of 
> the script you use to run your tests :)

see above. (It's no secret, i described components of this workload in 
one of my first mails to the adeos thread. Btw., what happened to adeos 
irq latency testing?)

	Ingo

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRHHTAV>; Wed, 8 Aug 2001 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbRHHTAN>; Wed, 8 Aug 2001 15:00:13 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:3593 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267233AbRHHS7z>; Wed, 8 Aug 2001 14:59:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Kravetz <mkravetz@sequent.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC][PATCH] Scalable Scheduling
Date: Wed, 8 Aug 2001 21:06:01 +0200
X-Mailer: KMail [version 1.2]
Cc: Hubertus Franke <frankeh@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com> <20010808112800.F1088@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010808112800.F1088@w-mikek2.des.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <0108082106010A.00351@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 August 2001 20:28, Mike Kravetz wrote:
> Yes we have, we'll provide those numbers with the updated patch.
> One challenge will be maintaining the same level of performance
> for UP as in the current code.  The current code has #ifdefs to
> separate some of the UP/SMP code paths and we will try to eliminate
> these.

Does it help if I clarify what Linus was suggesting?  Instead of:

         #ifdef CONFIG_SMP
                 .. use nr_running() ..
         #else
                 .. use nr_running ..
         #endif

write:

	inline int nr_running(void)
	{
	#ifdef CONFIG_SMP
		int i = 0, tot=nt_running(REALTIME_RQ);
		while (i < smp_num_cpus) {
			tot += nt_running(cpu_logical_map(i++));
		}
		return(tot);
	#else
		return nr_running;
	#endif
	}

Then see if you can make the #ifdef's go away from that too.  (If that's 
too hard, well, at least the #ifdef's are now reduced.)

--
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268858AbRHKVmO>; Sat, 11 Aug 2001 17:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268860AbRHKVly>; Sat, 11 Aug 2001 17:41:54 -0400
Received: from lanm-pc.com ([64.81.97.118]:14071 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S268858AbRHKVlo>;
	Sat, 11 Aug 2001 17:41:44 -0400
Date: Sat, 11 Aug 2001 16:32:31 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Tyan K7 thunder hang -- possible light at end of tunnel
Message-ID: <20010811163231.A13806@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We got a lot of helpful responses -- thanks, everybody.  People seem 
to find this an interesting problem, so I'm posting an update.

We've seen the hang three times under the uniprocessor kernel now.  'Tain't
the SMP code, apparently.  We also know it's not the Radeon 64, because
we saw the hang after yanking it and falling back to the on-board Rage
ATI XL.  

That sort of simplifies things.  It strongly suggests a hardware-level
problem, either a bad board or transient thermal failures.  But we now
have a third guess which I want to plausibility-check with the experts.

Gary moved the sound card (SB Live!) up one slot and dropped in one of
the two IBM UltraStar 36Z15s we were really supposed to be using in
this box (just 4.2msec seek time -- yum!).  We've since done a successful
RH workstation install, copied the X tree over, and successfully done
a `make clean' and `make World' (both were previously reliable ways to produce
the hang).

Can the kind of random lockups I previously reported be caused by a PCI IRQ
conflict?  Gary says he's solved box hangs like this before by moving the
sound card.  That might turn out to be the solution this time.  Another
possibility is that having the SB Live! sound module loaded helps produce
the problem.  Yet another possibility is that the drive we were previously
using was bad (and no, I don't see how a bad SCSI drive could plausibly
lock up the machine either).

We've captured dmesg's output, and moved the card back to its original slot.
We're going to dump dmesg, compare it with the  first capture, and test for
the hang by cleaning and building the X tree again.

Nineteen hours and counting...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Guard with jealous attention the public liberty.  Suspect every one
who approaches that jewel.  Unfortunately, nothing will preserve it
but downright force.  Whenever you give up that force, you are
inevitably ruined."	-- Patrick Henry, speech of June 5 1788

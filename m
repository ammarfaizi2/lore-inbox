Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284079AbRLELXs>; Wed, 5 Dec 2001 06:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284087AbRLELXi>; Wed, 5 Dec 2001 06:23:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8066 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284079AbRLELXZ>;
	Wed, 5 Dec 2001 06:23:25 -0500
Date: Wed, 05 Dec 2001 03:23:04 -0800 (PST)
Message-Id: <20011205.032304.102576056.davem@redhat.com>
To: rth@redhat.com
Cc: davidm@hpl.hp.com, schwab@suse.de, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: alpha bug in signal handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011204190048.B8179@redhat.com>
In-Reply-To: <20011204171426.B7982@redhat.com>
	<15373.33622.236872.92057@napali.hpl.hp.com>
	<20011204190048.B8179@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@redhat.com>
   Date: Tue, 4 Dec 2001 19:00:48 -0800

   On Tue, Dec 04, 2001 at 06:15:50PM -0800, David Mosberger wrote:
   > Oh, sorry, I was referring to teh *other* problem... ;-)
   > 
   > What I meant is that the check for re-scheduling
   > (current->need_resched) and signal deliverify (current->sigpending)
   > needs to be done with interrupts turned off, and the interrupts need
   > to be left off until user space is reached.  Otherwise, you could get
   > an interrupt which would wake up a higher priority task or post a
   > signal between the check and the return to user space.
   > 
   > I didn't see this interrupt disabling in the Alpha version of entry.S,
   > but I have to admit my Alpha assembly is getting quite rusty.
   
   Oh, yes, I see.  This should fix it.
   
I don't understand why this is even necessary.

What if the interrupt comes in on another processor.  How does this
return from trap behavior avoid that interrupt modifying the signal
and/or scheduling state wrt. the current cpu's task?

I think the change is bogus, we don't do this on sparc64 and things
have been perfectly fine.

And if the change isn't necessary, it's bad to disable interrupts for
a longer period of time than necessary.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTBYGZS>; Tue, 25 Feb 2003 01:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTBYGZS>; Tue, 25 Feb 2003 01:25:18 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:31951 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267697AbTBYGZR>; Tue, 25 Feb 2003 01:25:17 -0500
To: linux-kernel@vger.kernel.org
Subject: WARN_ON noise in 2.5.63's kernel/sched.c:context_switch
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Feb 2003 15:35:22 +0900
Message-ID: <buoadgkuatx.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a bunch of stack dumps from the WARN_ON newly added to 
kernel/sched.c:context_switch:

	if (unlikely(!prev->mm)) {
		prev->active_mm = NULL;
		WARN_ON(rq->prev_mm);
		rq->prev_mm = oldmm;
	}

The thing is, I'm hacking on uClinux, so I don't have an MMU, and the mm
stuff is purely noise.  What's the best way to squash this warning?

[Of course I'd like to just trash all the MM manipulation -- for me,
`context_switch' should really _just_ do `switch_to' -- but I'd settle
for just not having stack dumps litter my console output...]

Thanks,

-miles
-- 
80% of success is just showing up.  --Woody Allen

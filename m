Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRGFGms>; Fri, 6 Jul 2001 02:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbRGFGmi>; Fri, 6 Jul 2001 02:42:38 -0400
Received: from mail.necsom.com ([195.197.180.67]:24214 "EHLO
	mail.services.necsom.com") by vger.kernel.org with ESMTP
	id <S261561AbRGFGmd>; Fri, 6 Jul 2001 02:42:33 -0400
To: linux-kernel@vger.kernel.org
Subject: tasklets in 2.4.6
X-Face: "Df%<nszNB6]!2E>ff/A[8\G2b3+^!5to-ud=~>-GK'R3S00Csb"a2XD}:"E8Y(ZS4|d#5d!]Y];+I+8(L;jzZM`?M5$QkA>C@"?Y5@&^):)@<_S|q_*v$dgZYh%-Kw<_g,9pmme24Zr|d;dvwK}}.1,K!uP)/mX\=1IhOn7Lvr=k$">br]sxlslZ8m%g,v'y/l`X5oObnS)C^q<:DTgvV^|&`QuPHF]YZJ8`q|z^mkeP,.['pv1eMZzflI4RE|1}t&{Pp'c-M;t~@T2L$$YtuFzM$`P~aN48_ohw:KbSYPvx]:IBS`\g
From: Ville Nummela <ville.nummela@mail.necsom.com>
Date: 06 Jul 2001 09:42:29 +0300
Message-ID: <7an16iy2wa.fsf@necsom.com>
User-Agent: Gnus/5.090002 (Oort Gnus v0.02) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have little question about tasklets in the kernel 2.4.6:

In kernel/softirq.c, line 178:

                if (test_bit(TASKLET_STATE_SCHED, &t->state))
                        tasklet_schedule(t);

What's the idea behind this line? If the tasklet is already scheduled,
schedule it again? This does not make much sense to me.

Also, few lines before:

                       if (test_bit(TASKLET_STATE_SCHED, &t->state))
                                goto repeat;

Here we'll loop forever if the tasklet should schedule itself.

So if the tasklet schedules itself we'll loop it forever, and if it doesn't
it'll get never run again.
If we'd change the line 178 to:

                if (!test_bit(TASKLET_STATE_SCHED, &t->state))

the tasklet would get scheduled if it was NOT scheduled, and everything would
go on happily forever :)

But anyway, I'm probably missing something here, perhaps someone could educate
me a bit ;-)

-- 
 |   ville.nummela@necsom.com tel: +358-40-8480344               
 |   So Linus, what are we doing tonight?                             
 |   The same thing we every night Tux. Try to take over the world!   

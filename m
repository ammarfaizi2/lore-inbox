Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSASRmQ>; Sat, 19 Jan 2002 12:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSASRmH>; Sat, 19 Jan 2002 12:42:07 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:25281 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S286343AbSASRlz>; Sat, 19 Jan 2002 12:41:55 -0500
Date: Sat, 19 Jan 2002 18:41:49 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: O(1) scheduler: load_balance issues
Message-ID: <Pine.LNX.4.21.0201191826400.14284-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

while debugging the IA64 race-conditions with the new scheduler some
question/suggestion came to my mind.

In the load_balance() function the initial value for max_load should
better be set to 1 instead of 0 in order to avoid finding 'busiest'
runqueues with only one task. This avoids taking the spin-locks
unnecessarily for the case idle=1.

Another issue: I don't understand how prev_max_load works, I think that
the comments in load_balance are not true any more and the comparison to
prev_max_load can be dropped. In the loop where you compare wit hit it
will never have another value than 1000000000. Or am I completely
misunderstanding the code?

Thanks,

best regards,
Erich





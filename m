Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268694AbTBZJuk>; Wed, 26 Feb 2003 04:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268697AbTBZJuk>; Wed, 26 Feb 2003 04:50:40 -0500
Received: from PentiumII.bedroom.gen.nz ([202.6.5.6]:39181 "EHLO
	pentiumii.bedroom.gen.nz") by vger.kernel.org with ESMTP
	id <S268694AbTBZJuj>; Wed, 26 Feb 2003 04:50:39 -0500
Date: Wed, 26 Feb 2003 23:00:18 +1300 (NZDT)
From: Clive Nicolson <clive@baby.bedroom.gen.nz>
X-X-Sender: clive@pentiumii.bedroom.gen.nz
To: linux-kernel@vger.kernel.org
cc: Clive Nicolson <clive@baby.bedroom.gen.nz>
Subject: PROBLEM: [2.4.18-3] kernel BUG at softirq.c:194!
Message-ID: <Pine.LNX.4.44.0302262250460.14311-100000@pentiumii.bedroom.gen.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm (really I'm just the reporter) seeing the above kernel BUG, the code 
is thus (in tasklet_action):

	while (list) {
		struct tasklet_struct *t = list;

		list = list->next;

		if (tasklet_trylock(t)) {
			if (!atomic_read(&t->count)) {
				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
					BUG();
				t->func(t->data);
				tasklet_unlock(t);
				continue;
			}
		}

I dont see the problem on my slow PC's but it is seen at 900 Mhz!

Can someone give me a clue as to how a device driver may be inducing this!

Thanks
Clive


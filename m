Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317882AbSGKTin>; Thu, 11 Jul 2002 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317884AbSGKTim>; Thu, 11 Jul 2002 15:38:42 -0400
Received: from server72.aitcom.net ([208.234.0.72]:42905 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S317882AbSGKTik>;
	Thu, 11 Jul 2002 15:38:40 -0400
Message-Id: <200207111941.PAA31668@test-area.com>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: MAX_USER_RT_PRIO < MAX_RT_PRIO limits user-space?
Date: Thu, 11 Jul 2002 15:39:01 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry to post such a simple question but I'm having trouble comprehending the 
new priority range scheme used with O(1) and no one on kernelnewbies can help.

Documentation states that priorities are inverted.
It also states that the separation between MAX_USER_RT_PRIO and MAX_RT_PRIO 
allows kernel threads to have a higher priority if MAX_USER_RT_PRIO < 
MAX_RT_PRIO.

I don't see how this is possible because in setscheduler

* Valid priorities for SCHED_FIFO and SCHED_RR are
* 1..MAX_USER_RT_PRIO-1

and the p->static_prio for RT tasks is determined by

p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;

so the static_prio for a RT task has a range: [0 ... MAX_USER_RT_PRIO - 2 ]

Fluctuating MAX_USER_RT_PRIO will never prevent a RT process from accessing 
the bottom of the priority range. And lower means higher priority.

What am I misunderstanding?

Anton


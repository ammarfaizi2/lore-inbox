Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284850AbRL3UZX>; Sun, 30 Dec 2001 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284765AbRL3UZN>; Sun, 30 Dec 2001 15:25:13 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:21516 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284913AbRL3UZD>; Sun, 30 Dec 2001 15:25:03 -0500
Date: Sun, 30 Dec 2001 12:28:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: scheduler params ...
Message-ID: <Pine.LNX.4.40.0112301217280.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, after some test i'd suggest to reposition MM_AFFINITY_BONUS to 1
for a better interactive feeling.
The other issue is TICK_SCALE()/NICE_TO_TICKS() that does not permit fine
tuned time slices. I'd like to try shorter ts but the current shifting
implementation does not give enough control over final values. What about
having a table :

unsigned char ts_table[];

that is filled in sched_init() and is used like :

p->time_slice = ts_table[20 - p->nice];

The TICK_SCALE()/NICE_TO_TICKS() is no more critical because is now called
with a nr_running frequency and no more with a total processes frequency.




- Davide



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129048AbQKEMzE>; Sun, 5 Nov 2000 07:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKEMyy>; Sun, 5 Nov 2000 07:54:54 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:51173 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S129048AbQKEMyf>; Sun, 5 Nov 2000 07:54:35 -0500
Date: Sun, 5 Nov 2000 07:55:40 -0500 (EST)
From: <bobyetman@att.net>
To: linux-kernel@vger.kernel.org
Subject: Loadavg calculation
Message-ID: <Pine.LNX.4.21.0011050746090.634-100000@juryrig.worldnet.att.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working a project a work that is using Linux to run some very
math-intensive calculations.   One of the things we do is use the 1-minute
loadavg to determine how busy the machine is and can we fire off another
program to do more calculations.    However, there's a problem with that.

Because it's a 1 minute load average, there's quite a bit of lag time from
when 1 program finishes until the loadavg goes down below a threshold for
our control mechanism to fire off another program.

Let me give an example (all on a 1-cpu PC)

HH:MM:SS
00:00:00    		fire off 4 programs 
00:01:00		loadavg goes up to 4
00:01:30		3 of the 4 programs finish loadavg still at 4
00:02:20		load avg goes down to 1, below our threshold
00:02:21		we fire off 3 more programs.

We'd like to reduce that almost 50 second lag time.  Is it possible, in
user-space, to duplicate the loadavg calculation period, say to a 15
second load average, using the information in /proc?

The other option we looked at, besides using loadavg, was using idle pct%,
but if I read the source for top right, involves reading the entire
process table to calculate clock ticks used and then figuring out how many
weren't used.

Ideas, opinions welcome.  Yes, I read the list, so either respond direct
to me, or to the list.

bobyetman@att.net (Robert A. Yetman)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

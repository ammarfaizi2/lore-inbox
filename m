Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDHV51>; Sun, 8 Apr 2001 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDHV5R>; Sun, 8 Apr 2001 17:57:17 -0400
Received: from colorfullife.com ([216.156.138.34]:3601 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131157AbRDHV5D>;
	Sun, 8 Apr 2001 17:57:03 -0400
Message-ID: <3AD0DED3.10F478C9@colorfullife.com>
Date: Sun, 08 Apr 2001 23:57:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cpu binding bug?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Afaics cpu bindings could allow a thread to run with an "unlimited"
timeslice.

cpu0: one thread running with 'nice==19'.
	NICE_TO_TICKS==1.
	
cpu1: lots of other threads with 'nice==0' (NICE_TO_TICKS==6)

cpu0 will enter schedule() every tick.
can_schedule() returns '0' for all threads bound to cpu1, thus
'recalculate' will be called every tick - that's faster than the threads
on cpu1 can use up their slice.
The currently running thread will run forever.

Is that problem fixed in the patches that allow user space to write
cpus_allowed?

--
	Manfred

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUGPJL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUGPJL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUGPJL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:11:58 -0400
Received: from tor.morecom.no ([64.28.24.90]:35818 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S266495AbUGPJL4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:11:56 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Question on Linux and SCHED_FIFO scheduling for POSIX threads
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 16 Jul 2004 11:11:54 +0200
Message-ID: <40FB8221D224C44393B0549DDB7A5CE8378C37@tor.lokal.lan>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on Linux and SCHED_FIFO scheduling for POSIX threads
Thread-Index: AcRrFPAZBF9N+NJiQJ2hRg2fqu3Ciw==
From: =?iso-8859-1?Q?Eirik_Nordbr=F8den?= <eirik.nordbroden@morecom.no>
To: <linux-kernel@vger.kernel.org>
Cc: =?iso-8859-1?Q?B=E5rd_Laukvik?= <bard.laukvik@morecom.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Can anybody clarify how SCHED_FIFO scheduling and thread priorities works on Linux? We are novices in this field in the Linux environment and needs help to understand how it works. To verify the behaviour we made up a small test program consisting of four threads and a mutex. We have run the program on both the 2.6.5 and 2.6.7 kernels with same behaviour.

Program:

T-MAIN: scheduling policy=SCHED_FIFO, priority=1
T-LP:   scheduling policy=SCHED_FIFO, priority=10
T-MP:   scheduling policy=SCHED_FIFO, priority=20
T-HP:   scheduling policy=SCHED_FIFO, priority=30

The program runs like this:

T-MAIN locks mutex => T-MAIN runs.
T-MAIN creates T-LP => T-LP runs.
T-LP waits for mutex => T-MAIN runs.
T-MAIN creates T-MP => T-MP runs.
T-MP waits for mutex => T-MAIN runs.
T-MAIN creates T-HP => T-HP runs.
T-HP waits for mutex => T-MAIN runs.
T-MAIN waits 3 seconds and unlocks mutex => T-LP runs.
T-LP waits 3 seconds and unlocks mutex => T-MP runs.
T-MP waits 3 seconds and unlocks mutex => T-HP runs.
:
:

For us this is unexpected behaviour. We would expect that the thread with the highest priority would be scheduled to run when a number of threads is waiting for a mutex and the mutex is unlocked. Can anyone clarify this? Have we missed something?

PS We have also tested this with POSIX and System V semaphores in stead of the mutex with same behaviour.

Eirik Nordbrøden 
moreCom A/S  http://www.moreCom.no/
 

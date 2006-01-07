Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965408AbWAGCkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408AbWAGCkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965411AbWAGCkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:40:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:29178 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965409AbWAGCkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:40:10 -0500
In-Reply-To: <Pine.LNX.4.44L0.0601051820000.3110-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0601051820000.3110-100000@lifa02.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EB15893A-7F26-11DA-9F72-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: <dino@in.ibm.com>, <robustmutexes@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
From: david singleton <dsingleton@mvista.com>
Subject: robust futex deadlock detection patch
Date: Fri, 6 Jan 2006 18:40:09 -0800
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a new patch that provides both futex deadlock detection and 
prevents ill-behaved and
malicious apps from deadlocking the kernel through the robust futex 
interface.

	http://source.mvista.com/~dsingleton/patch-2.6.15-rt2-rf1

Deadlock detection is done 'up front' for both POSIX and robust 
pthread_mutexes.   Non-recursive
POSIX mutexes will hang if deadlocked, as defined by the POSIX spec.   
The wait channel they
are hung on is 'futex_deadlock'.  This wait channel makes it easy to 
spot that your POSIX app
has deadlocked itself via the 'ps' command.

Robust futexes will have -EDEADLK returned to them since there is no 
POSIX specification for
robust mutexes,  yet, and  returning -EDEADLK is more in the spirit of 
robustness.   Robust
mutexes are cleaned up by the kernel after a thread dies and they also 
report to the app if
it is deadlocking itself.

Deadlock detection is something I have wanted to provide for both debug 
and production kernels
for a while.  It was previously available through DEBUG_DEADLOCKS.  I 
needed to add the
deadlock dection code for both production and debug kernels to prevent 
applications hanging
the kernel.

David


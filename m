Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264605AbSIVW6R>; Sun, 22 Sep 2002 18:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264607AbSIVW6R>; Sun, 22 Sep 2002 18:58:17 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:17879 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264605AbSIVW6Q>; Sun, 22 Sep 2002 18:58:16 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 19:03:01 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209230101250.31981-100000@localhost.localdomain>
References: <15758.18582.488305.152950@k42.watson.ibm.com>
	<Pine.LNX.4.44.0209230101250.31981-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.19140.200081.346286@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > [...] On a technical note: a cache-line ping-ponging is bad - a global
 > > spinlock is horrendous. They're different - the lock-less MP scheme gets
 > > rid of them both.
 > 
 > (on the contrary - a global spinlock is bad for exactly that reason,
 > because it causes a cacheline ping-pong. So if two CPUs are trying to
 > write trace events at once, you'll get the same effect as if they were
 > using a global spinlock.)
 > 
 > 	Ingo

Just want to be clear that we are going to a per-CPU buffer scheme.

However, for sake of argument, the above is still not true.  A global lock
has a different (worse) performance problem then the lock-free atomic
operation even given a global queue.  The difference is 1) the Linux global
lock is very expensive and interacts with potential other processes, and 2)
you have to hold the lock for the entire duration of logging the event;
with the atomic operation you are finished once you've reserved you space.
If you didn't use the expensive Linux global lock and just a global lock,
you could be interrupted in the middle of holding the lock and performance
would fall off the map.

-bob


Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com


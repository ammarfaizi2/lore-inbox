Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVDAA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVDAA7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVDAA7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:59:46 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:12522 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262053AbVDAA7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 19:59:39 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331174927.GA11483@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
	 <1112290916.12543.19.camel@localhost.localdomain>
	 <20050331174927.GA11483@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 31 Mar 2005 19:59:33 -0500
Message-Id: <1112317173.28076.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I was wondering if the issue the bit_spin_lock has gone into the side
burner? I understand that this is a major problem to change it, if you
want to get into the mainline kernel. But I still believe it to be a
problem. With kjournald spinning on a bit lock until it finishes it's
quota, can be bad for latencies. 

Although it only deadlocks on your system if it was a real-time task, it
still has the ability to become one. Since it can hold two different
locks at the time of the spin, if a rt-task tries to grab it, with
priority inheritance it becomes rt, and if that just happened to be the
highest priority task on the system, you just created a deadlock.

It's not so much of an issue with me, since I'm working with a parallel
kernel, and have implemented my earlier fixes to it. I just wanted to
know if there's any plan to deal with them on your end.  I do see this
causing a random lockup once in a while, and wanted the user to beware.
Of course if you just avoid ext3, you wont have a problem.

-- Steve



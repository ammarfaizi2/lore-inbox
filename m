Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWAaXS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWAaXS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAaXS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:18:27 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:53511 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932074AbWAaXS0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:18:26 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Howard Chu" <hyc@symas.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Tue, 31 Jan 2006 15:18:05 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEJEJMAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
In-Reply-To: <43DDCFD0.1090505@aitel.hist.no>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 31 Jan 2006 15:14:58 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 31 Jan 2006 15:15:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I just wonder - what is the problem with this convoy formation?
> It can only happen when the cpu is overloaded, and in that case
> someone has to wait.  In this case, the mutex waiters. 

	The problem is that you need to become more efficient as load increases, not less. If you get more efficient as load increases, you can get into a situation where even though you have an amount of load you can handle, you will never catch up on the load that backed up before.
 
> Aggressively handing the cpu to whoever holds a mutex will mean the
> mutexes are free more of the time - but it will *not* mean less waiting in
> tghe system.  You just changes who waits.

	It will mean fewer context switches and more effective use of caches as load increases. Even a very small amount of "gets more efficient as load goes up" can mean the difference between a system that handles load spikes smoothly (with a temporary reduction in responsiveness) and a system that backs up in a load spike and never recovers (with a per,amently increasing reduction in responsiveness even with load that's normally tolerable).

	As load goes up, you need your threads to use more of their timeslice. This means not descheduling a running thread unless it is unavoidable.

	DS



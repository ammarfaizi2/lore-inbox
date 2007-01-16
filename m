Return-Path: <linux-kernel-owner+w=401wt.eu-S932463AbXAPIgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXAPIgQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbXAPIgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:36:16 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43198 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbXAPIgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:36:15 -0500
Message-ID: <45AC8E2A.3060708@bull.net>
Date: Tue, 16 Jan 2007 09:34:50 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu>
In-Reply-To: <20070112075816.GA23341@elte.hu>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/01/2007 09:44:29,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/01/2007 09:44:30,
	Serialize complete at 16/01/2007 09:44:30
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ingo Molnar a écrit :
> yeah. As an alternative, it might be a good idea to pthread-ify 
> hackbench.c - that should replicate the Volano workload pretty 
> accurately. I've attached hackbench.c. (it's process based right now, so 
> it wont trigger contended futex ops)

Ok, thanks. I've adapted your test, Ingo, and do some measures. (I've only 
replaced fork with pthread_create, I didn't use condvar or barrier for the first 
synchronization).
The modified hackbench is available here:

http://www.bullopensource.org/posix/pi-futex/hackbench_pth.c

I've run this bench 1000 times with pipe and 800 groups.
Here are the results:

Test1 - with simple list (i.e. without any futex patches)
=========================================================
Iterations=1000
Latency (s)      min      max      avg      stddev
                 26.67    27.89    27.14        0.19

Test2 - with plist (i.e. with only patch 1/4 as is)
===================================================
Iterations=1000
Latency (s)      min      max      avg      stddev
                 26.87    28.18    27.30        0.18

Test3 - with plist but all SHED_OTHER registered
         with the same priority (MAX_RT_PRIO)
(i.e. with modified patch 1/4, patch not yet posted here)
=========================================================
Iterations=1000
Latency (s)      min      max      avg      stddev
                 26.74    27.84    27.16        0.18


-- 
Pierre

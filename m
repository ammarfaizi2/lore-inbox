Return-Path: <linux-kernel-owner+w=401wt.eu-S932089AbXAQJA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbXAQJA4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbXAQJA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:00:56 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53198 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbXAQJAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:00:55 -0500
Message-ID: <45ADE56B.4010608@bull.net>
Date: Wed, 17 Jan 2007 09:59:23 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH 2.6.20-rc5 0/4] futexes functionalities and improvements
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 10:09:10,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 10:09:11,
	Serialize complete at 17/01/2007 10:09:11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Today, there are several functionalities or improvements about futexes included
in -rt kernel tree, which, I think, it make sense to have in mainline.

Among them, there are:
     * futex use prio list : allows RT-threads to be woken in priority order
instead of FIFO order.
     * futex_wait use hrtimer : allows the use of finer timer resolution.
     * futex_requeue_pi functionality : allows use of requeue optimization for
PI-mutexes/PI-futexes.
     * futex64 syscall : allows use of 64-bit futexes instead of 32-bit.

The following mails provide the corresponding patches.


I re-send this series for kernel 2.6.20-rc5 with this small modifications:

  - futex_use_prio_list patch stores now all non-real-time threads with the same
priority (MAX_RT_PRIO, which is a lower priority than real-time priorities),
causing them to be stored in FIFO order. RT-threads are still woken first in
priority order.
  - futex_requeue_pi: I've found (and corrected of course) a bug causing a
memory leak.

plist (patch 1/4) is still under discussion: I think it should be taken into
account, because it concerns a correctness issue with a very low cost as
drawback (I would even say "without noticeable cost" ;-) but that's my opinion
of course).
Anyway, I still can provide the same series without patch 1/4 if needed.

Comments and feedback are still welcome, as usual.

-- 
Pierre


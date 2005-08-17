Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVHQVfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVHQVfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVHQVfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:35:16 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:43234 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751297AbVHQVfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:35:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Thu, 18 Aug 2005 07:35:03 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508171903.43985.kernel@kolivas.org> <6bffcb0e0508171104311942ff@mail.gmail.com>
In-Reply-To: <6bffcb0e0508171104311942ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I26ADIOITnCcM+D"
Message-Id: <200508180735.04162.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_I26ADIOITnCcM+D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 18 Aug 2005 04:04, Michal Piotrowski wrote:
> Hi,
> here are additional staircase scheduler benchmarks.
>
> (make all -j8)
>
> scheduler:
> staircase
>
> sched_compute=1

> real    49m48.619s
> user    77m20.788s
> sys     6m7.653s

Very nice thank you.

Since you are benchmarking, here is an unofficial update to the staircase 
patch to the current non-plugsched version which will affect the results of 
interbench (it won't change the benchmark results of compute mode).

Cheers,
Con

--Boundary-00=_I26ADIOITnCcM+D
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="staircase_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="staircase_update.patch"

Index: linux-2.6.13-rc6-plugsched/kernel/staircase.c
===================================================================
--- linux-2.6.13-rc6-plugsched.orig/kernel/staircase.c	2005-08-18 07:32:34.000000000 +1000
+++ linux-2.6.13-rc6-plugsched/kernel/staircase.c	2005-08-18 07:33:10.000000000 +1000
@@ -64,8 +64,8 @@ int sched_compute = 0;
  *compute setting is reserved for dedicated computational scheduling
  *and has ten times larger intervals.
  */
-#define _RR_INTERVAL		((10 * HZ / 1000) ? : 1)
-#define RR_INTERVAL()		(_RR_INTERVAL * (1 + 9 * sched_compute))
+#define _RR_INTERVAL		((5 * HZ / 1000) ? : 1)
+#define RR_INTERVAL()		(_RR_INTERVAL * (1 + 19 * sched_compute))
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)

--Boundary-00=_I26ADIOITnCcM+D--

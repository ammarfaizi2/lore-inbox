Return-Path: <linux-kernel-owner+w=401wt.eu-S932204AbXARM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXARM2d (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 07:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbXARM2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 07:28:33 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52580 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbXARM2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 07:28:32 -0500
Message-ID: <45AF6790.8010000@bull.net>
Date: Thu, 18 Jan 2007 13:26:56 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, tglx@linutronix.de, khilman@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] futex null pointer timeout
References: <20070118002503.418478415@mvista.com> <20070118073816.GA28486@elte.hu>
In-Reply-To: <20070118073816.GA28486@elte.hu>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/01/2007 13:36:48,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/01/2007 13:36:49,
	Serialize complete at 18/01/2007 13:36:49
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
[...]
>> The patch reworks do_futex, and futex_wait* so a NULL pointer in the 
>> timeout position is infinite, and anything else is evaluated as a real 
>> timeout.
> 
> thanks, applied.
> 

On top of this patch, you will need the following patch: futex_lock_pi is also 
involved.

---
  futex.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
---

Signed-off-by: Pierre Peiffer <pierre.peiffer@bull.net>

---
Index: linux-2.6/kernel/futex.c
===================================================================
--- linux-2.6.orig/kernel/futex.c	2007-01-18 13:16:32.000000000 +0100
+++ linux-2.6/kernel/futex.c	2007-01-18 13:19:32.000000000 +0100
@@ -1644,7 +1644,7 @@ static int futex_lock_pi(u32 __user *uad
  	if (refill_pi_state_cache())
  		return -ENOMEM;

-	if (time->tv_sec || time->tv_nsec) {
+	if (time) {
  		to = &timeout;
  		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
  		hrtimer_init_sleeper(to, current);
@@ -3197,7 +3197,7 @@ static int futex_lock_pi64(u64 __user *u
  	if (refill_pi_state_cache())
  		return -ENOMEM;

-	if (time->tv_sec || time->tv_nsec) {
+	if (time) {
  		to = &timeout;
  		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
  		hrtimer_init_sleeper(to, current);

-- 
Pierre

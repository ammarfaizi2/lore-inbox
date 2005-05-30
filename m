Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVE3Qso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVE3Qso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVE3Qso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:48:44 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:12563 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261649AbVE3Qse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:48:34 -0400
Message-ID: <429B43AD.5060003@stud.feec.vutbr.cz>
Date: Mon, 30 May 2005 18:47:41 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <42978730.4040205@stud.feec.vutbr.cz> <20050528055322.GA14867@elte.hu> <429AE21C.2020309@stud.feec.vutbr.cz> <20050530143833.GA16609@elte.hu> <20050530145016.GA18433@elte.hu>
In-Reply-To: <20050530145016.GA18433@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------080807090005060406040506"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0002]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080807090005060406040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>>agreed - i've added your patch to my tree.
> 
> with a small modification: i turned the error into a link-time error, 
> because gcc parses both branches and will give a compiler-time warning 
> even if the proper compat_semaphore is used.

Oh, sorry. I actually had it produce a link-time error at first. But I 
wanted so much to make it fail at compile time that I screwed it up and 
didn't test both cases.

However, what you have in RT-V0.7.47-13 is still not correct. Now it 
again produces only a warning :-)
Patch attached. This time I really tested it in both cases. For struct 
semaphore it fails at link-time. For struct compat_semaphore it compiles 
without problems.

Michal

--------------080807090005060406040506
Content-Type: text/x-patch;
 name="rt_init_MUTEX_LOCKED.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_init_MUTEX_LOCKED.diff"

diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/include/linux/rt_lock.h linux-RT.mich/include/linux/rt_lock.h
--- linux-RT/include/linux/rt_lock.h	2005-05-30 18:40:07.000000000 +0200
+++ linux-RT.mich/include/linux/rt_lock.h	2005-05-30 18:29:53.000000000 +0200
@@ -210,7 +210,7 @@ extern void there_is_no_init_MUTEX_LOCKE
  * No locked initialization for RT semaphores
  */
 #define rt_init_MUTEX_LOCKED(sem) \
-		there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
+		there_is_no_init_MUTEX_LOCKED_for_RT_semaphores()
 extern void FASTCALL(rt_down(struct semaphore *sem));
 extern int FASTCALL(rt_down_interruptible(struct semaphore *sem));
 extern int FASTCALL(rt_down_trylock(struct semaphore *sem));

--------------080807090005060406040506--

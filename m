Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWENPbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWENPbS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWENPbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:31:18 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:20660 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751455AbWENPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:31:17 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -mm] update comment in rtmutex.c and friends
Date: Sun, 14 May 2006 17:28:03 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0605131846250.2208@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605131846250.2208@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605141728.05752.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Sunday, 14. May 2006 01:34, Steven Rostedt wrote:
> @@ -46,9 +46,15 @@
>   *
>   * The fast atomic compare exchange based acquire and release is only
>   * possible when bit 0 and 1 of lock->owner are 0.
> + *
> + * (*) There's a small time where the owner can be NULL and the
> + * "lock has waiters" bit is set.  This can happen when grabbing the lock.
> + * To prevent a cmpxchg of the owner releasing the lock, we need to set this
> + * bit before looking at the lock, hence the reason this is a transitional
> + * state.
>   */
> 
> -static void
> +static vid

Typo here.

>  rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
>  		   unsigned long mask)
>  {
> @@ -365,6 +371,7 @@ static int try_to_take_rt_mutex(struct r

PS: Compile testing ANY changes to *.c and *.h files
	will catch most obvious brown paper bag typos for you :-)

Regards

Ingo Oeser

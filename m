Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315466AbSEMB6M>; Sun, 12 May 2002 21:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSEMB6K>; Sun, 12 May 2002 21:58:10 -0400
Received: from [202.135.142.194] ([202.135.142.194]:38668 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315466AbSEMB6G>; Sun, 12 May 2002 21:58:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "BALBIR SINGH" <balbir.singh@wipro.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug CPU prep III: daemonize idle tasks 
In-Reply-To: Your message of "Thu, 09 May 2002 17:36:43 +0530."
             <AAEGIMDAKGCBHLBAACGBAELNCHAA.balbir.singh@wipro.com> 
Date: Mon, 13 May 2002 12:01:04 +1000
Message-Id: <E177597-0001TA-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <AAEGIMDAKGCBHLBAACGBAELNCHAA.balbir.singh@wipro.com> you write:
> I tried a version of __daemonize in 2.4. It panics in
> schedule()
> 
>         prepare_to_switch();
>         {
>                 struct mm_struct *mm = next->mm;
>                 struct mm_struct *oldmm = prev->active_mm;
>                 if (!mm) {
>                         if (next->active_mm) BUG();
> 
> I got hit by the BUG() in 2.4, I think prepare_to_switch has
> moved to specific archs in 2.5. A quick look showed that
> this issue no longer exists in 2.5.

Uhhh... there are many other problems if you are trying to do this on
a "live" process.  idle process creation is a special case because it
has never been run yet.

This is not a generic "daemonize this task" mechanism!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTEUODz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTEUODz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:03:55 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:47626 "EHLO smtp.uc3m.es")
	by vger.kernel.org with ESMTP id S262123AbTEUODx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:03:53 -0400
Date: Wed, 21 May 2003 16:16:51 +0200
Message-Id: <200305211416.h4LEGpL27134@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: "Robert White" <rwhite@casabyte.com>
Subject: Re: recursive spinlocks. Shoot.
X-Newsgroups: linux.kernel
In-Reply-To: <20030520231013$3d77@gated-at.bofh.it>
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030520231013$3d77@gated-at.bofh.it> you wrote:
> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
>> The lock must guarantee that recursion is not allowed. Or to put
>> it more bluntly, the lock must result in a single thread of execution
>> through the locked object.

> Where the HECK do you get that load of bull?  The one requirement of a
> MUTUAL EXCLUSION PRIMITIVE (a.k.a. mutex, a.k.a. lock) is *MUTUAL*
> EXCLUSIVITY.

:-) this reminds me of the post I didn't make. 

> All else is unfounded blither.

Hey, that was the word I used in the post I didn't make! I'm sort of
glad I didn't say it out loud - it ruins the argument.

Anyhow, I have now written a tool that can detect various improper uses of
locks. I've started out by detecting sleep under spinlock, but I'll go
on to other deadlocks.

  % ./c ../dbr/1/sbull..c
  <function name=sbull_ioctl file=sbull.c line=171 attr=S_SLEEP>
  <function name=sbull_request file=sbull.c line=361 attr=S_SLEEP>
  % 

Detects two functions in the target file that sleep. For that it had
to analyse 28K lines of C. Put a spinlock in the wrong place and ...


  % ./c test16
  sleep under spinlock at file="test16" line=30
  <function name=sbull_open file=test16 line=1 attr=S_SLEEP>

(I excised a function to fiddle with and put a call to one of the other
two in under a lock).

I'll make this available. As soon as I figure out some more of how
to define C contexts. It uses a database and I'm having trouble
deciding where something is first defined in C.

Peter

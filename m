Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTINLk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTINLkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:40:55 -0400
Received: from dp.samba.org ([66.70.73.150]:23768 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262366AbTINLkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:40:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier 
In-reply-to: Your message of "Fri, 12 Sep 2003 15:20:17 -0300."
             <3F620E61.4080604@terra.com.br> 
Date: Sun, 14 Sep 2003 21:39:01 +1000
Message-Id: <20030914114054.CC7CE2C0A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F620E61.4080604@terra.com.br> you write:
> 	Kills an unneeded set_current_state after schedule_timeout, since it 
> already guarantees that the task will be TASK_RUNNING.

I thought we already got rid of that once: damn thing won't die...

> 	Also, when setting the state to TASK_RUNNING, isn't that memory 
> barrier unneeded? Patch removes this memory barrier too.

I personally *HATE* the set_task_state()/__set_task_state() macros.
Simple assignments shouldn't be hidden behind macros, unless there's
something really subtle involved.

Personally, when there's a normal and a __ version of a function, I
use the normal version unless there's a real (performance or
correctness) reason.  (ie. I prefer the "think less" version 8).

I don't mind either way.  I'll roll it in the next update.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

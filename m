Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWEORqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWEORqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWEORqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:46:33 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:55708 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S965021AbWEORqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:46:30 -0400
Subject: Re: sched: 64-bit nr_running
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, rostedt@goodmis.org
In-Reply-To: <20060515163429.GA16328@elte.hu>
References: <1147707081.15392.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060515162526.GA16095@elte.hu>
	 <1147710445.15392.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060515163429.GA16328@elte.hu>
Content-Type: text/plain
Date: Mon, 15 May 2006 10:45:29 -0700
Message-Id: <1147715130.15392.99.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 18:34 +0200, Ingo Molnar wrote:

> well for performance it's usually best to just have the native
> machine 
> word size (i.e. long), unless there's some compelling data-structure 
> size argument. In any case it's not uncommon to use 'long' for such 
> types, even though some other aspect of the kernel limits it to less 
> than 64 (or even 32) bits.

I also noticed that struct task_struct -> state uses a volatile long ,
but it seems to only use a few bits . exit_state also uses a long type
and only uses a few bits .. They could be combined into one long (or
even and int) .. I noticed the comment below,

 * We have two separate sets of flags: task->state
 * is about runnability, while task->exit_state are
 * about the task exiting. Confusing, but this way
 * modifying one set can't modify the other one by
 * mistake.

I think if it was all inside macro's it wouldn't be so easy to
accidentally set the exit_state when touching just state .. 

Daniel


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268503AbSIRVKu>; Wed, 18 Sep 2002 17:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268404AbSIRVKu>; Wed, 18 Sep 2002 17:10:50 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:27657 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S268503AbSIRVKr>;
	Wed, 18 Sep 2002 17:10:47 -0400
Date: Wed, 18 Sep 2002 23:15:47 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918211547.GA14657@win.tue.nl>
References: <20020918182818.GA14629@win.tue.nl> <Pine.LNX.4.44.0209182038400.26337-100000@localhost.localdomain> <20020918201134.GC14629@win.tue.nl> <20020918202914.GA3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918202914.GA3530@holomorphy.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 01:29:14PM -0700, William Lee Irwin III wrote:

> I've seen no change in behavior with large PID_MAX.

Of course not. But people keep blaming the wrong routine.
I have said it a thousand times - nothing is wrong with get_pid().

Now proc_pid_readdir() takes a million times as long, so it would
be much more reasonable if people talked about it instead.
With 20000 processes it will visit 10^7 process structs
for one ps.

> It doesn't sound like you read the patch at all.

I looked at it and searched for base.c but didnt find it,
so concluded that the real problem was not addressed.

> > In procfs we have a very quadratic algorithm in proc_pid_readdir()/
> > get_pid_list(). Not a potential hiccup after 2^30 processes that some
> > may want to smoothe, but every single "ls /proc" or "ps".
> > What shall we do with /proc for all these people with 10^5 processes?
> > Andries
> 
> That is actually one of the easiest ways to take out one of my machines
> while it's running 10K or so tasks, mentioned a bit ago in this thread.

OK. So we now agree.

But it looks like your patch doesnt change this? Or did I overlook sth?

Andries

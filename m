Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTEHFT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 01:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTEHFT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 01:19:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261180AbTEHFT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 01:19:27 -0400
Date: Wed, 7 May 2003 22:31:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: rml@tech9.net, <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] How to write a portable "run_on" program?
In-Reply-To: <20030508051539.31CFA2C04B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0305072221120.16772-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Rusty Russell wrote:
> 	Currently you need to do the following in userspace to set your
> affinity portably:

This is not true, and as long as you continue to claim this, nobody sane 
can take you seriously.

I have several times told you that the proper way to do it is the same as 
for fd_set, and in fact you can use "fdset" as the CPU set _today_, even 
if it looks a bit strange.

In other words, the proper way to do set_cpu() is

	int set_cpu(int cpu)
	{
		fd_set cpuset;

		FD_ZERO(&cpuset);
		FD_SET(cpu, cpuset);
		return sched_setaffinity(getpid(), sizeof(cpuset), &cpuset);
	}

which is a HELL OF A LOT more readable than the crap you're spouting 
(either your "before" _or_ your "after" crap).

And if you want to make it more readable still, you make a "cpuset.h" 
header file that creates a "cpu_set" type instead of "fd_set". You can 
do it by search-and-replace of the fd_set stuff if you want to.

But yeah, if you by "portable" mean that it won't handle more than 1024 
CPUs, then I guess it isn't portable. But guess what? I don't care. If you 
seriously expect to have more than 1024 CPUs in the near future, make the 
cpu_set be bigger.

But I expect you to ignore this email too, the way you ignored my previous
ones. The same way I'll continue to ignore your idiotic patches.

		Linus


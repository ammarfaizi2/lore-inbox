Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSIOS1J>; Sun, 15 Sep 2002 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSIOS1J>; Sun, 15 Sep 2002 14:27:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18695 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318158AbSIOS1I>; Sun, 15 Sep 2002 14:27:08 -0400
Date: Sun, 15 Sep 2002 11:32:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209151902560.7866-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151128580.10830-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Ingo Molnar wrote:
> 
> the attached patch (against BK-curr + all my previous patches) implements
> one of the last missing POSIX threading details - exec() semantics.

Ingo, can you create a test-case to verify that a new-style thread can
sanely do

	if (!vfork())
		execve();
	thread_exit();

which leaves the other threads alive and well and is reasonably 
efficient..

I don't personally much like the POSIX execve() behaviour, and I'd like to 
make sure that it can be avoided for cases where that makes sense (ie a 
threaded app that wants to start some other helper program should be able 
to do so).

		Linus


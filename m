Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUFLNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUFLNsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUFLNsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:48:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:12423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264788AbUFLNsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:48:02 -0400
Date: Sat, 12 Jun 2004 06:47:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Dominik_Stra=DFer?= <einmal_rupert@gmx.de>
cc: Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid()
 bug in 2.6?]
In-Reply-To: <40CAC9BE.6050400@gmx.de>
Message-ID: <Pine.LNX.4.58.0406120645420.2903@evo.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com>
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com>
 <40C33A84.4060405@elegant-software.com> <Pine.LNX.4.58.0406061013250.7010@ppc970.osdl.org>
 <40CAC9BE.6050400@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Jun 2004, Dominik Straßer wrote:
>
> I am facing the following problem:
> I want to sum up the time spent in the main thread + all threads that 
> ever existed.
> getrusage dosn't work (and didn't do so in pre-NPTL-times) as the time 
> spent in threads is not taken into account.

Hmm.. That's likely a bug. It definitely should work, but I guess the 
self-reaping ends up meaning that the time never gets percolated to the 
parent any more.

Ingo, any comments/ideas?

> To work around this problem I created a map pid->time used which used 
> getpid in the pre-NPTL-time and looked up the time in /proc/<pid>. As 
> this doesn't work with NPTL, changed it to use the gettid syscall as I 
> didn't find a saner way.

Changing it to gettid sounds like the right thing to do, but I also think 
that you shouldn't _need_ to do things like this.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSHMPYg>; Tue, 13 Aug 2002 11:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHMPYf>; Tue, 13 Aug 2002 11:24:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46866 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318161AbSHMPYe>; Tue, 13 Aug 2002 11:24:34 -0400
Date: Tue, 13 Aug 2002 08:30:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208130826000.5192-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> the attached patch implements a new syscall on x86, clone_startup().

Hmm.

Please don't do that CLONE_STARTUP flag thing. Just do the code inside the 
sys_clone_startup(), instead of dynamically adding a new flag. And that 
code looks like it returns EFAULT without freeing the stuff it has 
allocated.

Also, "caching" &tsk->thread only adds code - even if it makes the sources
slightly shorter. It adds a register that is just a constant offset from
another register.

Other than that the thing seems to make sense.

		Linus


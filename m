Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282803AbRK0Eti>; Mon, 26 Nov 2001 23:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282802AbRK0Et1>; Mon, 26 Nov 2001 23:49:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:35849 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282800AbRK0EtV>;
	Mon, 26 Nov 2001 23:49:21 -0500
Subject: Re: a nohup-like interface to cpu affinity
From: Robert Love <rml@tech9.net>
To: Linux maillist account <l-k@mindspring.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
In-Reply-To: <E16744i-0004zQ-00@localhost>
	<Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
	<1006472754.1336.0.camel@icbm> <E16744i-0004zQ-00@localhost> 
	<5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 26 Nov 2001 23:49:48 -0500
Message-Id: <1006836589.842.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-26 at 23:41, Linux maillist account wrote:
> Robert and Ingo,
> A nohup-like interface to the cpu affinity service would be useful.  It 
> could work like the following example:
> 
>     $ cpuselect -c 1,3-5 gcc -c module.c
> 
> which would restrict this instantiation of gcc and all of its children to 
> cpus 1,3,4, and 5.  This tool can be implemented in a few lines of C, with
> either /proc or syscall as the underlying implementation.

I can see the use for this, but you can also just do `echo whatever >
/proc/123/affinity' once it is running ... not a big deal.

It is automatically inherited by its children.

> On another subject -- capabilities -- any process should be able to reduce 
> the number of cpus in its own cpu affinity mask without any special
> permission.  To add cpus to a reduced mask, or to change the cpu affinity
> mask of other processes, should  require the appropriate capability, be it
> CAP_SYS_NICE, CAP_SYS_ADMIN, or whatever is decided.

My patch already does this.  If the user writing the affinity entry is
the same as the user of the task in question, everything is fine.  If
the user possesses the CAP_SYS_NICE bit, he can set any task's
affinity.  See the patch.

	Robert Love


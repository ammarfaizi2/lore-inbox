Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbSIROtm>; Wed, 18 Sep 2002 10:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbSIROtm>; Wed, 18 Sep 2002 10:49:42 -0400
Received: from holomorphy.com ([66.224.33.161]:17130 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266839AbSIROtl>;
	Wed, 18 Sep 2002 10:49:41 -0400
Date: Wed, 18 Sep 2002 07:49:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918144939.GU3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain> <20020918123206.GA14595@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020918123206.GA14595@win.tue.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 02:32:06PM +0200, Andries Brouwer wrote:
> I still don't understand the current obsession with this stuff.
> It is easy to have pid_max 2^30 and a fast algorithm that does not
> take any more kernel space.
> It seems to me you are first creating an unrealistic and unfavorable
> situation (put pid_max at some artificially low value, starting a
> lot of tasks and saying: look! the algorithm is quadratic!) and
> then solve the problem that you thus invented yourself.
> Please leave pid_max large.
> Andries

There is no obsession. This just happens to be a real life issue.

Basically, the nondeterministic behavior of these things is NMI oopsing
my machines and those of users (who often just cut the power instead of
running the NMI oopser). get_pid() is actually not the primary offender,
but is known to be problematic along with the rest of them. I don't
really care whose pet algorithm is used so long as it doesn't explode
when breathed on. And Ingo's algorithm looks excellent to me.

This is furthermore blocking VM testing and development for many tasks
scenarios meant to emulate and optimize usage typical of machines in
the field.


Bill

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312152AbSCRAac>; Sun, 17 Mar 2002 19:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312148AbSCRAaY>; Sun, 17 Mar 2002 19:30:24 -0500
Received: from slip-202-135-75-217.ca.au.prserv.net ([202.135.75.217]:1173
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312146AbSCRAaJ>; Sun, 17 Mar 2002 19:30:09 -0500
Date: Sun, 17 Mar 2002 18:17:32 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-Id: <20020317181732.48f85421.rusty@rustcorp.com.au>
In-Reply-To: <20020315101309.A13609@wotan.suse.de>
In-Reply-To: <20020314195122.A30566@wotan.suse.de>
	<E16lj03-0007Zm-00@wagner.rustcorp.com.au>
	<20020315101309.A13609@wotan.suse.de>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 10:13:09 +0100
Andi Kleen <ak@suse.de> wrote:

> On Fri, Mar 15, 2002 at 03:07:27PM +1100, Rusty Russell wrote:
> > They must return an lvalue, otherwise they're useless for 50% of cases
> > (ie. assignment).  x86_64 can still use its own mechanism for
> > arch-specific per-cpu data, of course.
> 
> Assignment should use an own macro (set_this_cpu()) or use per_cpu().

So, we'd have "get_this_cpu(x)" and "set_this_cpu(x, y)".  So far, so good.

	struct myinfo
	{
		int x;
		int y;
	};

	static struct myinfo mystuff __per_cpu_data;

Now how do we set mystuff.x on this CPU?

I just think you're going to have to live with the generic implementation.
It's really not that bad 8)

Sorry,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

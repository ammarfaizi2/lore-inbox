Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSCSAPy>; Mon, 18 Mar 2002 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCSAPp>; Mon, 18 Mar 2002 19:15:45 -0500
Received: from ns.suse.de ([213.95.15.193]:8719 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293317AbSCSAPf>;
	Mon, 18 Mar 2002 19:15:35 -0500
Date: Tue, 19 Mar 2002 01:15:34 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020319011534.A32751@wotan.suse.de>
In-Reply-To: <20020318083511.A19810@wotan.suse.de> <E16n74r-00024V-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 11:02:09AM +1100, Rusty Russell wrote:
> In message <20020318083511.A19810@wotan.suse.de> you write:
> > On Sun, Mar 17, 2002 at 06:17:32PM +1100, Rusty Russell wrote:
> > > On Fri, 15 Mar 2002 10:13:09 +0100
> > > Andi Kleen <ak@suse.de> wrote:
> > > 
> > > > On Fri, Mar 15, 2002 at 03:07:27PM +1100, Rusty Russell wrote:
> > > > > They must return an lvalue, otherwise they're useless for 50% of cases
> > > > > (ie. assignment).  x86_64 can still use its own mechanism for
> > > > > arch-specific per-cpu data, of course.
> > > > 
> > > > Assignment should use an own macro (set_this_cpu()) or use per_cpu().
> > > 
> > > So, we'd have "get_this_cpu(x)" and "set_this_cpu(x, y)".  So far, so good.
> > > 
> > > 	struct myinfo
> > > 	{
> > > 		int x;
> > > 		int y;
> > > 	};
> > > 
> > > 	static struct myinfo mystuff __per_cpu_data;
> > > 
> > > Now how do we set mystuff.x on this CPU?
> > 
> > set_this_cpu(mystuff.x, y) could be eventually supported properly, it just
> > needs compiler work (and before that can use address calculation & reference)
> 
> I think the effort would be better spent on teaching the compiler
> about these special variables, and how to do efficient assignments on
> them.

That would be the idea. gcc would learn how to use the %gs segment prefix
(similar to the equivalent feature in Windows compilers). The only
drawback is that it still cannot easily load the address except if you
define some silly convention (like a pointer to the segment base being
always stored at the segment base address) 

But it is a lot of work to teach gcc about the multiple address spaces...

-Andi

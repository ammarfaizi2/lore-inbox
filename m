Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311229AbSCRHfd>; Mon, 18 Mar 2002 02:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSCRHfX>; Mon, 18 Mar 2002 02:35:23 -0500
Received: from ns.suse.de ([213.95.15.193]:1038 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311229AbSCRHfT>;
	Mon, 18 Mar 2002 02:35:19 -0500
Date: Mon, 18 Mar 2002 08:35:11 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020318083511.A19810@wotan.suse.de>
In-Reply-To: <20020314195122.A30566@wotan.suse.de> <E16lj03-0007Zm-00@wagner.rustcorp.com.au> <20020315101309.A13609@wotan.suse.de> <20020317181732.48f85421.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 06:17:32PM +1100, Rusty Russell wrote:
> On Fri, 15 Mar 2002 10:13:09 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Fri, Mar 15, 2002 at 03:07:27PM +1100, Rusty Russell wrote:
> > > They must return an lvalue, otherwise they're useless for 50% of cases
> > > (ie. assignment).  x86_64 can still use its own mechanism for
> > > arch-specific per-cpu data, of course.
> > 
> > Assignment should use an own macro (set_this_cpu()) or use per_cpu().
> 
> So, we'd have "get_this_cpu(x)" and "set_this_cpu(x, y)".  So far, so good.
> 
> 	struct myinfo
> 	{
> 		int x;
> 		int y;
> 	};
> 
> 	static struct myinfo mystuff __per_cpu_data;
> 
> Now how do we set mystuff.x on this CPU?

set_this_cpu(mystuff.x, y) could be eventually supported properly, it just
needs compiler work (and before that can use address calculation & reference)

&this_cpu(mystuff, y) will always be slow.

-Andi


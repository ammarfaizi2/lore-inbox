Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSIMDJo>; Thu, 12 Sep 2002 23:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSIMDJo>; Thu, 12 Sep 2002 23:09:44 -0400
Received: from dp.samba.org ([66.70.73.150]:7136 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S313628AbSIMDJn>;
	Thu, 12 Sep 2002 23:09:43 -0400
Date: Fri, 13 Sep 2002 13:14:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
Message-ID: <20020913031429.GQ32156@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209121520300.28515-100000@serv> <20020913015502.1D43F2C070@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913015502.1D43F2C070@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 11:30:47AM +1000, Paul 'Rusty' Russell wrote:
> In message <Pine.LNX.4.44.0209121520300.28515-100000@serv> you write:
> > Hi,
> > 
> > On Thu, 12 Sep 2002, Rusty Russell wrote:
> > 
> > > Nope, that's one of the two problems.  Read my previous post: the
> > > other is partial initialization.
> > >
> > > Your patch is two-stage delete, with the additional of a usecount
> > > function.  So you have to move the usecount from the module to each
> > > object it registers: great for filesystems, but I don't think it buys
> > > you anything (since they were easy anyway).
> > 
> > I'm aware of the init problem, what I described was the core problem,
> > which prevents any further cleanup.
> 
> I don't think of either of them as core, they are two problems.

Actually, with one stage init, module unload is essentially a special
case of module load failure, consider:
	module_init()
	{
		/* initialize stuff */
		...

		wait_event_interruptible(wq, 0 == 1);

		/* clean stuff up */
		...
		return -EINTR
	}

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319786AbSIMWie>; Fri, 13 Sep 2002 18:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319812AbSIMWie>; Fri, 13 Sep 2002 18:38:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10882 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S319786AbSIMWid>; Fri, 13 Sep 2002 18:38:33 -0400
Subject: RE: Killing/balancing processes when overcommited
From: "Timothy D. Witham" <wookie@osdl.org>
To: "Timothy D. Witham" <wookie@osdl.org>
Cc: jimsibley@earthlink.net, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, thunder@lightweight.ods.org
In-Reply-To: <1031956299.2317.240.camel@wookie-t23.pdx.osdl.net>
References: <Springmail.0994.1031951614.0.51325400@webmail.pas.earthlink.net> 
	<1031956299.2317.240.camel@wookie-t23.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 15:38:23 -0700
Message-Id: <1031956703.1403.245.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 15:31, Timothy D. Witham wrote:
>   
> On Fri, 2002-09-13 at 14:13, Jim Sibley wrote:
> > 
> > 
> > Tim wrote:
> > >  There is another solution.  And that is never >allocate memory unless
> > >you have swap space.  Yes, the issue is that you >need to have lots of
> > >disk allocated to swap but on a big machine you >will have that space.
> > 
> > How do you predict if a program is going to ask for more memory? Maybe it only
> > needs additional memory for a short time and is a good citizen and gives it
> > back?
> > 
> 
>   Well its been a bit so the details are fuzzy but you have a pointer

  Counter, I meant to say "a counter as to " instead of "a pointer to". 

:-)

> to how much space you have left in you allocated swap and when you get
> memory you decrement space and when you release memory in increment it
> so that it indicates how much you have left.  If you try and malloc
> more than you free then you go and reserve another chunk of swap.
> 
> > How much disk needs to be allocated for swap? In 32 bit, each logged in user
> > is limited to 2 GB, so do we need 2 GB for each logged on user? 250 users, 500
> > GB of disk?
> >
> 
>   It turns out that for the high load database machines this is about
> 3 to 4 times the actual physical memory.
> 
>  
> > In a 64 bit system, how much swap would you reserve?
> >
> 
>   Same as 32 bit machines doesn't apply.
> 
>  
> > Actually, another OS took this approach in the early 70's and this was quickly
> > junked when they found out how much disk they really had to keep in reserve
> > for paging.
> > 
> 
>   But there are many current OS's that do this and are quite successful.
> 
> > >  This way the offending process that asks for >more memory will be
> > >the one that gets killed.  Even if the 1st couple >of ones aren't the
> > >misbehaving process eventually it will ask for >more memory and suffer
> > >process execution.  
> > 
> > It may not be the "offending process" that is asking for more memory. How do
> > you judge "offending?"
> > 
> 
>   In this case the offense is asking for more memory.  So it is the
> process that asks for more memory that goes away.  Again sometimes
> it will be an innocent bystander but hopefully it will eventually
> be the process that is causing the problem.
> 
>   Many databases program for this condition.  The stuff that absolutely
> must be up and running preallocates all of the memory that it needs
> at startup.  Any new memory requests that are denied might cause a
> transaction to fail but they won't bring down the whole database.
> 
> Tim
> > 
> > 
> > 
> > 
> -- 
> Timothy D. Witham - Lab Director - wookie@osdlab.org
> Open Source Development Lab Inc - A non-profit corporation
> 15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
> (503)-626-2455 x11 (office)    (503)-702-2871     (cell)
> (503)-626-2436     (fax)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)


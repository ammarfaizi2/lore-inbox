Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSHGLAn>; Wed, 7 Aug 2002 07:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSHGLAn>; Wed, 7 Aug 2002 07:00:43 -0400
Received: from ns.suse.de ([213.95.15.193]:22537 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317308AbSHGLAm>;
	Wed, 7 Aug 2002 07:00:42 -0400
Date: Wed, 7 Aug 2002 13:04:17 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020807130417.A19231@wotan.suse.de>
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com.suse.lists.linux.kernel> <p73vg6nhtsb.fsf@oldwotan.suse.de> <1028721043.18478.265.camel@irongate.swansea.linux.org.uk> <20020807124153.A8592@wotan.suse.de> <1028722608.18156.280.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028722608.18156.280.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 01:16:48PM +0100, Alan Cox wrote:
> On Wed, 2002-08-07 at 11:41, Andi Kleen wrote:
> > I don't see why it is unmaintainable. What is so bad with these ifs? 
> > 64bit cleanness is just another dependency, nothing magic and fundamentally
> > hard.
> 
> Lets take I2O block the if rule would
> 
> if [ $CONFIG_X86 = "y" -a $CONFIG_X86_64 != "y" ] 
> 	dep_bool ...  


dep_bool .... $CONFIG_X86_32

Would that be acceptable for you?  (ok that would not cover ppc32 for 
example, but they may have other issues with the driver) 
				  
> The actual rule being if 32bit little endian || 64bit little endian with
> kernel memory objects always below 4Gb and having PCI bus

I don't see it as a that big problem. It just needs a few more negated
generic symbols defined (e.g. CONFIG_32BIT CONFIG_4GB_ONLY 
CONFIG_LITTLE_ENDIAN), then it could be easily expressed with dep_... even 
in the traditional configuration language. I also don't think it would
be particularly unmaintainable to have these things in Config.

> 
> 
> Thats just one non too complicated driver. CML1 can't handle this
> scalably, maybe CML2 could have. 
> 
> Secondly you actually want people to discover stuff doesn't work so you
> can persuade them to go and fix it. Stick up a 'Good/Probably

They will discover it when they don't find a driver for an device and
can then find the disabled configuration and look into fixing it
(for someone able to fix the driver checking the configuration should
be trivial) 

In my opinion it is just not acceptable when the enable the driver by
mistake or load the wrong module and it crashes.

> Ok/Bad/Hopeless' driver listing on x86_64.org, then once Hammer becomes
> in general use post it to the janitor list now and then

That will be likely done anyways, but it is not enough.

-Andi

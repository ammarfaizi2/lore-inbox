Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEBh5>; Sat, 4 Nov 2000 20:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEBhr>; Sat, 4 Nov 2000 20:37:47 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:63760 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129030AbQKEBhi>; Sat, 4 Nov 2000 20:37:38 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC2C@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Russell King <rmk@arm.linux.org.uk>
Cc: "'David Woodhouse'" <dwmw2@infradead.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: RE: USB init order dependencies.
Date: Sat, 4 Nov 2000 17:36:51 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While Jeff and I basically agree on the short-term
solution (if one is still needed, altho I'm not aware of
any init order problems in USB in 2.4.0-test10), my
recollection of Linus's preference (without
looking it up) is to remove the calls from init/main.c
and to use __initcalls.

~Randy

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> Sent: Saturday, November 04, 2000 12:25 AM
> To: Russell King
> Cc: Dunlap, Randy; 'David Woodhouse'; torvalds@transmeta.com;
> linux-kernel@vger.kernel.org
> Subject: Re: USB init order dependencies.
> 
> 
> Russell King wrote:
> > 
> > Dunlap, Randy writes:
> > > David is entitled to his opinion (IMO).
> > > And I dislike this patch, as he and I have already discussed.
> > >
> > > Short of fixing the link order, I like Jeff's suggestion
> > > better (if it actually works, that is):  go back to the
> > > way it was a few months ago by calling usb_init()
> > > from init/main.c and making the module_init(usb_init);
> > > in usb.c conditional (#ifdef MODULE).
> > 
> > However, that breaks the OHCI driver on ARM.  Unless we're 
> going to start
> > putting init calls back into init/main.c so that we can 
> guarantee the order
> > of init calls which Linus will not like, you will end up 
> with a lot of ARM
> > guys complaining.
> > 
> > Linus, your opinion would be helpful at this point.
> 
> Back when some of the initial USB initcall stuff started appearing,
> there were similar discussions, similar problems, and similar
> solutions.  I was also wondering how fbdev (which needs to give you a
> console ASAP) would work with initcalls, etc.  At the time (~6 months
> ago?), Linus' opinion was basically "if the link order 
> hacking starts to
> get ugly, just put it in init/main.c"  So, Randy really should be
> calling the quoted text above "Linus' suggestion" ;-)
> 
> Putting a call into init/main.c isn't a long term solution, but it
> should get us there for 2.4.x...  init/main.c is also the 
> best solution
> for ugly cross-directory link order dependencies.  I would 
> say the link
> order of foo.o's in linux/Makefile is the most delicate/fragile of all
> the Makefiles...  touching linux/Makefile link order this 
> close to 2.4.0
> is asking for trouble.  Compared to that, adding a few lines to
> init/main.c isn't so bad.
> 
> IMHO,
> 
> 	Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

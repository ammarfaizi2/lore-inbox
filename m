Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbQKDI0Y>; Sat, 4 Nov 2000 03:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132582AbQKDI0P>; Sat, 4 Nov 2000 03:26:15 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:780 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S132562AbQKDI0G>;
	Sat, 4 Nov 2000 03:26:06 -0500
Message-ID: <3A03C7C7.87CE750F@mandrakesoft.com>
Date: Sat, 04 Nov 2000 03:24:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "Dunlap, Randy" <randy.dunlap@intel.com>,
        "'David Woodhouse'" <dwmw2@infradead.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: USB init order dependencies.
In-Reply-To: <200011031038.eA3Accj30162@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Dunlap, Randy writes:
> > David is entitled to his opinion (IMO).
> > And I dislike this patch, as he and I have already discussed.
> >
> > Short of fixing the link order, I like Jeff's suggestion
> > better (if it actually works, that is):  go back to the
> > way it was a few months ago by calling usb_init()
> > from init/main.c and making the module_init(usb_init);
> > in usb.c conditional (#ifdef MODULE).
> 
> However, that breaks the OHCI driver on ARM.  Unless we're going to start
> putting init calls back into init/main.c so that we can guarantee the order
> of init calls which Linus will not like, you will end up with a lot of ARM
> guys complaining.
> 
> Linus, your opinion would be helpful at this point.

Back when some of the initial USB initcall stuff started appearing,
there were similar discussions, similar problems, and similar
solutions.  I was also wondering how fbdev (which needs to give you a
console ASAP) would work with initcalls, etc.  At the time (~6 months
ago?), Linus' opinion was basically "if the link order hacking starts to
get ugly, just put it in init/main.c"  So, Randy really should be
calling the quoted text above "Linus' suggestion" ;-)

Putting a call into init/main.c isn't a long term solution, but it
should get us there for 2.4.x...  init/main.c is also the best solution
for ugly cross-directory link order dependencies.  I would say the link
order of foo.o's in linux/Makefile is the most delicate/fragile of all
the Makefiles...  touching linux/Makefile link order this close to 2.4.0
is asking for trouble.  Compared to that, adding a few lines to
init/main.c isn't so bad.

IMHO,

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

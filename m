Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263458AbSJGWus>; Mon, 7 Oct 2002 18:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262752AbSJGWus>; Mon, 7 Oct 2002 18:50:48 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:27298 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S263458AbSJGWuI>; Mon, 7 Oct 2002 18:50:08 -0400
Date: Mon, 7 Oct 2002 16:20:48 -0700
From: Matt Porter <porter@cox.net>
To: Rob Landley <landley@trommello.org>
Cc: Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>,
       giduru@yahoo.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007162048.A19216@home.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021005.212832.102579077.davem@redhat.com> <20021007092212.B18610@home.com> <20021007214053.36F16622@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021007214053.36F16622@merlin.webofficenow.com>; from landley@trommello.org on Mon, Oct 07, 2002 at 12:41:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:41:08PM -0400, Rob Landley wrote:
> On Monday 07 October 2002 12:22 pm, Matt Porter wrote:
> > On Sat, Oct 05, 2002 at 09:28:32PM -0700, David S. Miller wrote:
> 
> > > The common areas, like smaller hashtables or whatever, sure put a
> > > CONFIG_SMALL_KERNEL option in there and start submitting the
> > > one-liners here and there that do it.
> >
> > Ahhh, but you just defeated the ideal of being able to customize
> > to task.  This is where the hallowed "the user is dumb" theory
> > bites us in the ass.  A single option to control all these sizing
> > issues reduces flexibility and that is what the embedded system
> > designer is looking for.
> 
> Or it the Great Big Lever gives them something to grep for if they want to do 
> fine-tuned tweaking and need to find all the places it might pay to give a 
> closer look to.

I can buy that too.  It would be a great improvement over instructing
people to grok all one bazillion lines of kernel code to understand
how to tweak an area that might need to be massaged in three places.
 
> > The ideal situation is if as we work
> > on all these areas where we can reduce size, we provide fine
> > grained options to tweak them (with a default desktop/server value
> > and a default "tiny" value).
> 
> 8000 controls you have to individually tweak to do anything is not 
> necessarily an improvement over a single "do what I want" button.  (User 
> Interface Design 101.)

Well, now you are at the other end of the spectrum.  I'm not suggesting
we head over that far.  Some popular "high impact" areas could be
provided the finer grained controls and the others could just be
lumped together.  I think there can be a middle ground that's
beneficial.
 
> The doorknob is a wonderful user interface...

Yes. :)
 
> > You can have this CONFIG_TINY or
> > whatever, but then we should also provide the ability to tweak
> > the values exactly how we want in a specific application.  The
> > tweaking options can be buried under advanced kernel options
> > with the appropriate disclaimers about shooting yourself in
> > the foot.
> 
> Or they could play in the source code if their needs are sufficiently 
> unusual, which more or less by definition they will be in this case.  No 
> matter how thorough you are here, there will be things they want to tweak (or 
> would if they knew about them) that there is no config option for.  "make 
> menuconfig" is not a complete replacement for knowing C in all cases.

True, but there are a number of people out there who want to do say
a kernel port to XYZ custom board.  They learn some basic kernel
knowledge, but we can't expect them to be a guru of everything to
get some work done.

One thing that happens with even a little more flexibility is that
the amount of traffic about tweaking things go down a bit.  Not a
"sizing" type tweak, but I often get questions about optimizing
kernel VM space on high-end PPC systems. We put in some options
so that TASK_SIZE, PAGE_OFFSET, and PKMAP_BASE can be easily
tweaked...now it's easy to tell somebody where to look to make
a change.  Before that, it was necessary to explain both places
that mod needed to be made to move KERNELBASE to a smarter value.

Now, one thing I consider at this point is that if we do think
about even a *little* more fine-grained settings, config options
may not be the place to collect them.  We could just have a common
include to catch all these things.  That would hide it away from
the "dumb users" a bit and even provide a basis for a mechanism
to have some different system "profiles" perhaps.  CONFIG_TINY,
CONFIG_DESKTOP, CONFIG_SERVER..who knows.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

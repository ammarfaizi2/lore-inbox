Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287317AbSALS7O>; Sat, 12 Jan 2002 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287319AbSALS7F>; Sat, 12 Jan 2002 13:59:05 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:17055 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S287317AbSALS6r>; Sat, 12 Jan 2002 13:58:47 -0500
Message-ID: <005301c19b9b$6acc61e0$0501a8c0@psuedogod>
From: "Ed Sweetman" <ed.sweetman@wmich.edu>
To: "Andrea Arcangeli" <andrea@suse.de>, <yodaiken@fsmlabs.com>
Cc: <jogi@planetzork.ping.de>, "Robert Love" <rml@tech9.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <nigel@nrg.org>,
        "Rob Landley" <landley@trommello.org>,
        "Andrew Morton" <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sat, 12 Jan 2002 14:00:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sat, Jan 12, 2002 at 09:52:09AM -0700, yodaiken@fsmlabs.com wrote:
> > On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> > > I did my usual compile testings (untar kernel archive, apply patches,
> > > make -j<value> ...
> >
> > If I understand your test,
> > you are testing different loads - you are compiling kernels that may
differ
> > in size and makefile organization, not to mention different layout on
the
> > file system and disk.

Can someone tell me why we're "testing" the preempt kernel by running
make -j on a build?  What exactly is this going to show us?  The only thing
i can think of is showing us that throughput is not damaged when you want to
run single apps by using preempt.  You dont get to see the effects of the
kernel preemption because all the damn thing is doing is preempting itself.

If you want to test the preempt kernel you're going to need something that
can find the mean latancy or "time to action" for a particular program or
all programs being run at the time and then run multiple programs that you
would find on various peoples' systems.   That is the "feel" people talk
about when they praise the preempt patch.  make -j'ing something and not
testing anything else but that will show you nothing important except "does
throughput get screwed by the preempt patch."   Perhaps checking the
latencies on a common program on people's systems like mozilla or konqueror
while doing a 'make -j N bzImage'  would be a better idea.

> Ouch, I assumed this wasn't the case indeed.
>
> >
> > What happens when you do the same test, compiling one kernel under
multiple
> > different kernels?
>
> Andrea


You should _always_ use the same kernel tree at the same point each time you
rerun the test under a different kernel.  Always make clean before rebooting
to the next kernel.  setting up the test bed should be pretty straight
forward.   make sure the build tree is clean then make dep it.   reboot to
the next kernel.   load up mozilla but nothing else (mozilla should be
modified a bit to display the time it takes to do certain functions such as
displaying drop down menus, loading, opening a new window. Also you should
make the homepage something on the drive or blank.).  start make -j 4
bzImage then load mozilla (no other gnome gtk libraries or having them
loaded via running gnome doesn't matter, just as long as it's the same each
time).  Mozilla should then output times it takes to do certain things and
that should give you a good idea of how the preempt patch is performing
assuming everything is running on the same priority and your memory isn't
being maxed out and your hdd isn't eating the majority of the cpu time.

But i really think make -j'ing and only testing that or reporting those
numbers is a complete waste of time if you're trying to look at the
preempt's patch performance.  I like using mozilla in this example because
it's a big bulky app that most people have (kde users possibly excluded)
where an improvement in latency or "time to action" is actually important to
people, and cant be easily ignored.

well those are just my two cents,  i'd do it myself but i'm waiting for
hardware to replace the broken crap i have now.  but if nobody has done it
by then i'll set that up.

-formerly safemode


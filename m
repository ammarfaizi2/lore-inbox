Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUADW6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUADW6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:58:32 -0500
Received: from web40613.mail.yahoo.com ([66.218.78.150]:61833 "HELO
	web40613.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265373AbUADW62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:58:28 -0500
Message-ID: <20040104225827.39142.qmail@web40613.mail.yahoo.com>
Date: Sun, 4 Jan 2004 23:58:27 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
To: azarah@nosferatu.za.org, Con Kolivas <kernel@kolivas.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <1073227359.6075.284.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Martin Schlemmer <azarah@nosferatu.za.org> a écrit : > On
Sun, 2004-01-04 at 14:45, Con Kolivas wrote:
> > On Sun, 4 Jan 2004 22:13, Martin Schlemmer wrote:
> > > On Sun, 2004-01-04 at 10:49, Con Kolivas wrote:
> > > > > I added a fprintf(stderr, "%d\n", amount); to that
> code and indeed
> > > > > amount was *always* 1 no matter what I did (it even
> was 1 when the
> > > > > (dmesg/...) output came in fast). And jump scrolling
> would take place
> > > > > if amount > 59 in my case... can this still be not a
> schedulers issue ?
> > > > >
> > > > >
> > > > > Looking at that how can it not be a scheduling problem
> ....
> > > >
> > > > Scheduling problem, yes; of a sort.
> > > >
> > > > Solution by altering the scheduler, no.
> > > >
> > > > My guess is that turning the xterm graphic candy up or
> down will change
> > > > the balance. Trying to be both gui intensive and a
> console is where it's
> > > > happening. On some hardware you are falling on both
> sides of the fence
> > > > with 2.6 where previously you would be on one side.
> > >
> > > So its Ok for 'eye candy' to 'lag', but xmms should not
> skip?  Anyhow,
> > > its xterm that he have issues with, not gnome-terminal or
> such with
> > > transparency.  I smell something ...
> > 
> > Sigh... 
> > 
> > Xmms was a simple test case long forgotten but most still
> think all I did was 
> > make an xmms scheduler. Deleting one character from sched.c
> before all of my 
> > patches would make the scheduler ideal for xmms. Any
> braindead idiot can tune 
> > a scheduler for just one application.
> 
> Well, its the favorite example 8)
> 
> >  An application that changes it's 
> > behaviour dynamically well in the setting of a particular
> scheduler, though? 
> > Should a scheduler be tuned to suit a coding style or quirk?
> 
> > 
> 
> But the scheduler changes to a particular application?  I
> still am of
> opinion that the current scheduler in mainline 'breaks'
> priorities ...
> call it dynamic tuning or whatever you like.  Now something
> gets
> priority while something else starves.
> 
> > I should go back to lurking before people start calling me
> names. This thread 
> > has gone long enough for that. If I hadn't said anything it
> would have died 
> > out by now.
> 
> Well, I have stayed out of this for months now, as its always
> 'they' at
> fault - that app, or piece of code.  Sure, I am one of those
> whining
> users, and I have no particular interest in the scheduler code
> - that
> is if it behaves like it should.  But whatever is in now, just
> do not
> behave as expected, and call it a feature or whatever you
> want, if it
> deviates the definition, then what should we call it?  Or if
> its a
> feature, can we have the weirdness in priorities disabled by
> default
> with a sysctl or sysfs switch?
> 
> > Instead I'm drawing attention to my fundamentally flawed
> code.
> > 
> 
> The scrolling is but one part.  Just starting an app, or
> running
> 'vim /etc/fstab' for example takes ages some times, even with
> minimal load.  If xterm, gnome-term, aterm, multi-gnome-term,
> etc is broken, how do we fix it then?  What about some of the
> other issues?  If its a problem with those apps, why is it I
> still
> wonder what they are doing wrong, and it not fixed?
> 
> Do not worry, _I_ will go back to lurking about this issue
> _again_,
> but after _once_again_ seeing a issue about this being blown
> off
> as being something wrong with 'it', and some facts (you did
> see
> that the skipping code for the other user _never_ kicked in)
> were just ignored, I just could not help myself - sorry.
> 
> At least I will not experience those issues of the others, and
> hopefully Nick will not stop his work, or things change too
> much
> to adapt his patch.
> 

how much free memory do you have when this happens ?
I had 
a similar problem. It was easily reproducive doing 
a du -sh / and then trying to do other things.
It didn't happend all the time but most of the time

Doing a 
echo 16384 >/proc/sys/vm/min_free_kbytes
seems to help the kernel remember that it has some swap and he
*has* to use it in some cases

> 
> Thanks,
> 
> -- 
> Martin Schlemmer
> 

> ATTACHMENT part 2 application/pgp-signature name=signature.asc


=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.

_________________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com

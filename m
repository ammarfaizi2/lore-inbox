Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbRLAXVS>; Sat, 1 Dec 2001 18:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282479AbRLAXVJ>; Sat, 1 Dec 2001 18:21:09 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:62141 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282482AbRLAXUu>; Sat, 1 Dec 2001 18:20:50 -0500
Date: Sat, 1 Dec 2001 16:20:53 -0700
Message-Id: <200112012320.fB1NKro03024@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C093F86.DA02646D@wanadoo.fr>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
	<9u9qas$1eo$1@penguin.transmeta.com>
	<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
	<3C0898AD.FED8EF4A@wanadoo.fr>
	<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
	<3C093F86.DA02646D@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> Richard Gooch wrote:
> > 
> > Pierre Rousselet writes:
> > > Richard Gooch wrote:
> > > > Indeed I do. Please Cc: me on devfs related stuff. And please apply
> > > > devfs-patch-v200, which fixes a stupid typo. I'd also be interested in
> > > > knowing the behaviour with 2.4.17-pre1.
> > 
> > Did you apply devfs-patch-v200?
> > 
> Well, I am now back with 2.4.16 and devfsd-1.3.18. Playing with
> devfs is a risky game.

I assume if you use kernel 2.4.16 with devfsd-1.3.20 that there is no
Oops?

> I applied devfs-patch-v200 against 2.5.1-pre5 :
> And I got an oops when booting with devfsd-1.3.20. Luckily, I get the
> same oops when booting without devfsd and starting it after loging in.
> Here it is
> 
> ksymoops 2.4.3 on i686 2.5.1-pre5.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.5.1-pre5/ (default)
>      -m /usr/src/linux/System.map (default)

Did you install the appropriate System.map in /usr/src/linux? If not,
please use the -m option to specify the correct System.map file.

> > > > and boot messages. And booting with
> > >
> > > Difficult, I have no log in this case. I don't see unusual message
> > > before the oops except :
> > 
> > I need those boot messages.
> 
> Here is a log of a successful boot with devfs-patch-v200 but without
> starting devfsd. 

Well, that doesn't help. I need to see the boot messages with when it
fails. And I need the debugging output from passing "devfs=dall" to
the kernel as well.

> > > none already mounted on /dev
> > 
> > Edit your /etc/fstab and remove the line for devfs. You don't
> > need/want that if you have CONFIG_DEVFS_MOUNT=y.
> 
> no problem

I assume that didn't help. It would be helpful if you said so
explicitely.

> > > /dev is only a mountpoint on my system. I have no other fallback without
> > > devfs but a working kernel (thanksfully there are plenty).
> > >
> > > > "devfs=dall" is required as well.
> > >
> > > No option appended (no 'devfs='). grub.
> > 
> > I know nothing about grub. Somehow, you need to pass "devfs=dall" to
> 
> maybe I should pass an option but so far it was working without any,
> as you can see it in the command line from the log above.

Argh! I want to see the boot messages when "devfs=dall" is passed,
*for the failure case*! Otherwise I don't know exactly at which point
it fails, nor do I know what has happened prior to the failure point.
These kinds of bugs are usually the result of a chain of events, so I
need to see what's been going on, a step at a time. Hence
"devfs=dall".

> > the kernel when booting. And I need to see the boot messages when this
> > option is given to the kernel. If it's too verbose, you can try
> > "devfs=dreg,dunreg,dfree" instead. Copy the messages down by hand if
> > you need to, but I need to see them. Do yourself a favour and set up a
> > serial console so you can capture boot messages easily.
> 
> I'll try my best, I like devfs.

Great. That will help in getting full debugging information.

> > Also, make sure you are not using any proprietary drivers (like
> > NVidia). If you have such drivers, move them to another directory to
> 
> no chance

I'm not asking you to give up using NVidia drivers forever, but it's
very important that those drivers are not loaded until the Oops has
happened, you've captured the boot messages, run them through ksymoops
and either mailed them to me, or at the very least saved them to a
file for later emailing. By moving the NVidia drivers, you ensure that
they aren't autoloaded prior to Oops generation and debug capturing.

If you're unwilling to move those drivers elsewhere (I don't see why
this is a problem for you: you can live without them for a few
minutes), then neither I nor anyone else on this list can or will help
you. Binary-only drivers like NVidia cause no end of problems, and
kernels with them loaded (or even once loaded and then unloaded) are
not debuggable by the community. For all I know, the NVidia driver
abuses devfs in some way, and there isn't a bug in devfs itself. But
not having the source, *I can't be sure*. And since I don't know, I
can't help.

Just why are you unwilling to move those drivers?

> > prevent their being loaded. Even if you load but don't use such
> > drivers, they still make debugging information unreliable.
> > 
> > I've had a look at the code, and I see no reason for devfs to fail in
> > this way, unless some driver is abusing it.
> 
> I would suspect 1st devfsd. 2.4.16 is not happy at all with
> devfsd-1.3.20, even rxvt fails to find a terminal.

Devfsd is just a user-space process, and can't cause an Oops unless
there is a kernel bug (i.e. a devfs bug, or maybe a driver bug). I
believe that devfsd-v1.3.20 should not make it more likely to get an
Oops than when using devfsd-1.3.18. If devfsd-v1.3.20 really does
trigger an Oops while 1.3.18 doesn't then please try 1.3.19 and report
the results.

A separate issue is why rxvt doesn't work. Again, it's important to
try devfsd-v1.3.19 to see if that also breaks rxvt. If so, report and
also send a strace output of rxvt so I can see what's going wrong
there.

Finally, please try kernel 2.4.17-pre1, which has the latest version
of devfs. The 2.5.1-pre kernels have a lot of new experimental code
which could be causing some of the problems. By using 2.4.17, it
limits the changes to (mostly) devfs, so limits the variables. When
you use 2.5.1, I can't tell if there is a bug in devfs, or perhaps
some driver which is doing something illegal with devfs.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

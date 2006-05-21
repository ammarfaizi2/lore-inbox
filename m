Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWEUVK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWEUVK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 17:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWEUVK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 17:10:27 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:41570 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932384AbWEUVK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 17:10:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjHcGkO48QxZ8GvhAUbn96HQmeannhnya3zz/VFANN6rnoxXJSsmE5YzSgX898iwbXs/dfpKtKiwH8TVtCm2pkBBSU9+kjRkF9SPI/8aJY7BpugTxj6KGci8vIhPoHZOMzmqhX16iw3Zeadg0r9rB7XsQJQoEO+TOZcXkPgBGJc=
Message-ID: <5bdc1c8b0605211410ld978047x3c4ad37ec79f5e8c@mail.gmail.com>
Date: Sun, 21 May 2006 14:10:26 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: 2.6.16-rt22/23 kernels hanging after registering IO schedulers
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Clark Williams" <williams@redhat.com>,
       "Robert Crocombe" <rwcrocombe@raytheon.com>
In-Reply-To: <Pine.LNX.4.58.0605211321400.28717@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0605191022l7114707fjd6b3cdcfe68b97c7@mail.gmail.com>
	 <Pine.LNX.4.58.0605211321400.28717@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 19 May 2006, Mark Knecht wrote:
>
> > Hi Ingo and others,
> >    It's been quite awhile since I wrote anything here. I have been
> > using the 2.6.15-rt kernels for audio work on my AMD64 machine, but I
> > haven't written much music lately so the work load has been very low.
> > Actually I've found that for light work the standard Gentoo 2.6.16
> > kernel without -rt patches has been good enough for my real-time needs
> > of late so thanks to all the kernel developers for those more results
> > also.
> >
> >    Working quite nicely on my system are:
> >
> > 2.6.15-rt18
>
> Well this is good to hear.
>
> > 2.6.16-gentoo-r2
> >
> >    Some Gentoo oriented folks created a new 'pro-audio' overlay which
> > allows Gentoo users to build both applications and -rt kernels using
> > normal portage methods. Here's the link:
> >
> > http://proaudio.tuxfamily.org/wiki/index.php?title=Main_Page
>
> Also interesting to know.
>
> >
> >    Since the newest -rt kernels are part of the overlay I thought I'd
> > give building and booting one a try. At the time the version in the
> > overlay was 2.6.16-rt22 so I tried that. Unfortunately the boot
> > process hangs immediately after some messages about registering IO
> > schedulers.
> >
> >    My method to build 2.6.16-rt22 was to emerge the source from the
> > pro-audio overlay, copy the 2.6.15-rt18 .config file, run make
> > oldconfig, make menuconfig, make && make modules_install, and then
> > copy the kernel source to /boot.
> >
> >    My method to build 2.6.16-rt23 was to download linux-2.6.16, unzip
> > and untar, patch it with the -rt23 patch from your site, then again
> > use the 2.6.15-rt18 .config file as in the previous paragraph. Same
> > results.
> >
> >    I did try changing the default IO Scheduler, as well as leaving a
> > few out. I still hang at the same place.
> >
> >    My guess is that it's the step immediately after registering these
> > schedulers that's hanging but I no longer have a second computer so I
> > cannot do the console thing with the serial cable. Sorry.
> >
> >    Again, no serious problems for me since both 2.6.15-rt18 &
> > 2.6.16-gentoo-r2 are working great, but I thought I should at least
> > report this to see if there is some known thing I need to change or,
> > if not, make sure you are aware of the problem.
> >
> >    Here's some very basic info about the hardware
> >
>
> OK, there's been other reports of problems with booting AMD64 with the
> latest -rt kernels.  I just got home from Germany, and will start testing
> on my machine tomorrow.  I'll let you know what I find then.
>
> -- Steve

Hi Steve,
   It's good to hear from you and great if you can take a look at
this. I did some more ground work and now feel bad that I didn't
report back much earlier. It appears that the problems have started
with the very first revision of 2.6.16-rt support. I am currently
writing you from 2.6.16 from kernel.org which booted fine. However
2.6.16-rt1 fails the same way as all the later kernels that I tried
with a hang right after registering the schedulers.

   To try finding a place where the problem started I also tried
2.6.15-rt21 which was the last 2.6.15-rt kernel in the pro-audio
overlay. That kernel works fine also so it seems to be something right
at the beginning of the 2.6.16 series.

   If this could possibly be something in my .config files let me know
and I'll try making changes directed by you or Ingo there.

   I hope this info might help you get to the problem a little more quickly.

Cheers,
Mark

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWGQPGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWGQPGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGQPGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:06:37 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:8904 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750824AbWGQPGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:06:36 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1153146757.24228.28.camel@idefix.homelinux.org>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
	 <1152975857.6374.65.camel@idefix.homelinux.org>
	 <1152978284.16617.7.camel@mindpipe>
	 <1153009392.6374.77.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
	 <1153044864.6374.135.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161254260.9870@localhost.localdomain>
	 <1153137181.24228.16.camel@idefix.homelinux.org>
	 <1153144753.652.12.camel@localhost.localdomain>
	 <1153146757.24228.28.camel@idefix.homelinux.org>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 11:06:07 -0400
Message-Id: <1153148767.1218.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:32 +1000, Jean-Marc Valin wrote:
> > Have you thought about using something like Xen?  Have a virtual machine
> > that you can even give root access to users, and still have control of
> > the actual physical machine.
> 
> What does Xen have to do with that? I don't want to run stuff in another
> virtual machine, just on my desktop. Also, no matter how good the
> virtualization is, if the host eats CPU, the guest doesn't have it. 

What exactly is it that you want? Limit an RT process, but not limit
it???

> 
> > One issue I think you might have is what exactly is a CPU limit?  If the
> > system is idle, and you have an app that goes into a busy loop, do you
> > kill it after it hits the limit, even if it isn't RT?  Or do you just
> > force it to schedule?  Or do you consider idle a special case?  Do you
> > want just the apps to be limited, or all the apps that belong to a
> > specific user.
> 
> The standard was is to simply demote ill-behaved tasks to SCHED_OTHER or
> suspend them temporarily, i.e. limit the percentage of CPU they can get
> over a certain period of time.
> 
> > >From this thread, it seems your goal is to have a single console that
> > users can log into and run a RT thread for audio but still not be able
> > to lock up the entire system. Right?  So having an RT limit for this use
> > might actually be beneficial.  But this is a very rare case, and if you
> > are the only one needing this type of feature, then it will likely not
> > make it into the kernel.  
> 
> Rare case? So you never use a VoIP app (sure they can work as non-rt,
> but you get much better quality as latency goes down)? How about media
> players that don't skip? There are lots of uses for low-latency (i.e. rt
> scheduling) on a desktop. Pro audio people are the first to benefit, but
> all users can see an improvement.

If I need something that requires RT I simply set it to be RT.  That is
not what you are asking.  You want something to be RT but limited.  This
_is_ a rare case AFAIC.

> 
> > But it if turns out that lots of people like
> > this feature, and want it, then it might have a chance, if there is no
> > other way to accomplish it.
> 
> There *are* lots of people who want it and who have been complaining for
> quite a while (see threads on linux-audio-dev). All that's missing is a
> tiny bit, which makes it even more frustrating.

People want their RT apps to have a CPU limit?

> 
> > Currently, it looks like you can use either Xen or just stick to one of
> > the patches you mentioned earlier.
> 
> Sure, I can patch my kernel, but then the distros will just keep on
> ignoring the problem, which is bad.

It could just be me. I'm not into audio, and the RT apps that I use are
in a controlled environment.  So please educate me and tell me what
exactly is it that you want and why?  And not just a buggy RT app that
takes down the system.  That is expected behavior.  And it is possible
to control that in user space.

-- Steve



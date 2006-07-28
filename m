Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWG1MA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWG1MA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbWG1MA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:00:29 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:18707 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161109AbWG1MA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:00:28 -0400
Date: Fri, 28 Jul 2006 07:59:56 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Jim Gettys <jg@laptop.org>
Cc: Paul Mackerras <paulus@samba.org>, Andi Kleen <ak@suse.de>,
       a.zummo@towertech.it, jg@freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060728115956.GA5577@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <p73bqrc5rbu.fsf@verdi.suse.de> <17609.21005.415970.234577@cargo.ozlabs.ibm.com> <1154057388.10570.132.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154057388.10570.132.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 11:29:48PM -0400, Jim Gettys wrote:
> The only awkward thing about the current interfaces is that you have to
> go from seconds and microseconds, to milliseconds, but only really when
> you represent time to X clients, which requires a bit of 64 bit of
> math...    It is true that since you have two values in the timeval
> structure, the update might require some sort of locking, which could be
> a performance lose; but there are other simple solutions to that (e.g.
> simple ring representations where you rely on the store of an index
> value to be atomic without requiring full locks and increment the index
> after updating both values, but a simple memory barrier), but those
> implementation tricks should be hidden behind an interface, and not
> exposed to application programmers..
> 
> In theory, that conversion to milliseconds only actually has to be done
> if the time is (significantly) different.
> 
> I can't forsee that this is a big deal on (most of) today's machines.
> Last I looked, the CPU runs the same speed in kernel mode as user
> mode ;-).
> 
> On the other hand, the idea of a one off Linux specific "oh, there is
> this magic file you mmap, and then you can poke at a magic location",
> strikes me as a one-off hack, and that Linux would be better off
> spending the same effort to speed up the general interface (which might
> very well do this mmap trick trick behind the scenes, as far as I'm
> concerned).
> 
> The difference is one is a standard, well known interface, which to an
> application programmer has very well defined semantics; the other, to be
> honest, is a kludge, which may expose applications to too many details
> of the hardware.  For example, exact issues of cache coherency and
> memory barriers differ between machines.
>                                 Regards,
>                                     - Jim
> 
> 
> If it's to be a kludge, it might as well be a X driver kludge (which is
> where we put it in the '80's).
> 
> 
So, setting aside for the moment any potential usefullness to X, what about the
same question in the general sense?  Is this a usefull interface to add to the
rtc driver in general, without consideration for what applications might use it?

Neil

> 
> 
> On Fri, 2006-07-28 at 09:53 +1000, Paul Mackerras wrote:
> > Andi Kleen writes:
> > 
> > > No, no, it's wrong. They should use gettimeofday and the kernel's job
> > > is to make it fast enough that they can. 
> > 
> > Not necessarily - maybe gettimeofday's seconds + microseconds
> > representation is awkward for them to use, and some other kernel
> > interface would be more efficient for them to use, while being as easy
> > or easier for the kernel to compute.  Jim, was that your point?
> > 
> > Paul.
> -- 
> Jim Gettys
> One Laptop Per Child
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

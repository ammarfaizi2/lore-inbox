Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSKSKHe>; Tue, 19 Nov 2002 05:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSKSKHe>; Tue, 19 Nov 2002 05:07:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17493 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264875AbSKSKHb>; Tue, 19 Nov 2002 05:07:31 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org> <3DD99EA6.4010000@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2002 03:13:37 -0700
In-Reply-To: <3DD99EA6.4010000@us.ibm.com>
Message-ID: <m1of8l27fy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Eric W. Biederman wrote:
> > kexec is a set of systems call that allows you to load another kernel
> > from the currently executing Linux kernel.  The current implementation
> > has only been tested, and had the kinks worked out on x86, but the
> > generic code should work on any architecture.
> > Could I get some feed back on where this work and where this breaks.
> > With the maturation of kexec-tools to skip attempting bios calls,
> > I expect a new the linux kernel to load for most people.  Though I
> > also expect some device drivers will not reinitialize after the reboot.
> 
> I give it a big thumbs-up.  

And you thought I was kidding when I said it was mostly working :)

> Between the NUMAQs and the big xSeries machines, we
> have a lot of slow rebooters.  The 16GB intel boxes take at about 5 minutes to
> get back to the bootloader after a reboot, and the 4 and 8-quad NUMAQ's take
> closer to 10.

Wow. 10 minutes is a pain.  That certainly explains your interest...
 
> The IBM machines I've tried it on are a 4-way and 8-way PIII.  They both have
> aic7xxx cards and the 8-way has a ServeRAID 4 controller. They have a collection
> 
> of acenic, e1000, pcnet32 and eepro100 net cards.  All seem to work just fine.
> 
> The NUMAQ is another story, though.  I get nothing after "Starting new kernel".
> But, I wasn't expecting much.  The NUMAQ is pretty weird hardware and god knows
> what is actually happening.  I'll try it some more when I'm more confident in
> what I'm doing.

I suspect the hardware shutdown and start up logic for NUMAQ cpus needs some
special handling.   Does kexec_test not print anything, or were you not patient
enough?
 
> What's the deal with "FIXME assuming 64M of ram"?  I was a little surprised when
> 
> my 16GB machine started to OOM as I did a "make -j8 bzImage" :)  Why is it that
> you need the memory size at load time?

Small steps.   When I bypass the BIOS I need to get all of the information
the kernel normally would get from the BIOS from someplace else.  Currently
you can use the "mem= " kernel command line parameters.  Of you can dig the
/proc/iomem and /proc/meminfo and other places and get the BIOS's memory map.
There isn't a really good source, so I started with something that would work,
and I will work the user space tools up to something that works well.

I will happily accept patches :)

Eric

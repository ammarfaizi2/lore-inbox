Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288794AbSAIExk>; Tue, 8 Jan 2002 23:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288795AbSAIExb>; Tue, 8 Jan 2002 23:53:31 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:527 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288794AbSAIExV>;
	Tue, 8 Jan 2002 23:53:21 -0500
Date: Tue, 8 Jan 2002 20:51:09 -0800
From: Greg KH <greg@kroah.com>
To: felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020109045109.GA17776@kroah.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109042331.GB31644@codeblau.de>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 02:34:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:23:31AM +0100, Felix von Leitner wrote:
> My understanding of what "initramfs programs" actually means is vague at
> best.  Are these just programs that are intended to work in an initial
> ram disk?  Or is it a special collection that is included in the kernel
> distribution?

I don't know if they will be included in the kernel distribution or not.
But they will be part of the kernel build process, if only to copy them
to the ramfs image which is then added to the kernel image.

The dietHotplug program will need to be built each time against the
kernel that it is going to be bundled up with (that's how it gets the
size improvements.)

Maybe in the end, specialized programs like dietHotplug will become part
of the kernel source tree, due to them being so tightly bound to it.
Does anyone else have any thoughts about this?

> I don't see why we would need to include those programs with the kernel.
> The kernel tries hard to provide backwards compatibility to old versions
> of syscalls that have changed over the years.  That's why we _have_ a
> standard.  Also, we don't ship glibc with the kernel sources, and we
> didn't when our libc was Linux specific.

These programs are basically the movement of a lot of existing in-kernel
code, to userspace.  And as they need to be bundled up within the kernel
image itself, they don't need to have to run on any kernel but that one.

> If we follow that argumentation and are talking here about programs that
> aren't included in the kernel, why demand a specific libc for them at
> all?  Of course glibc is out of the question, but both the kernel API
> _and_ the libc API are standardized.  It does not make sense to write
> code that demands a specific libc if it can be avoided.  If you need
> any special syscall supported that is not yet part of the diet libc or
> uClibc, Eric and I will probably be glad to add support for it.

Great!  We are needing a small libc for these userspace programs.  A
limited number of libc functions, and a clean syscall interface.

> > 	- portable, runs on all platforms that the kernel currently
> > 	  works on, but doesn't have to run on any non-Linux based OS.

You didn't address this.  What are the future plans of porting dietLibc
to the platforms that are not currently supported by it (but are by
Linux)?

> When you link statically, it does not matter whether the libc also
> supports the rest of POSIX.  The size of libc.a does not matter.  It
> only matters which parts are referenced.  Since we are talking about new
> software specifically written for Linux and with the goal to be small,
> there are no legacy requirements to cater to.  We can write code without
> printf and stdio, for example.  Also, we probably don't need regular
> expressions or DNS.  Those are the big space hogs when linking
> statically against a libc.  In the diet libc, all of the above are very
> small, but avoiding them in the first place is better then optimizing
> them for small size.
> 
> And if we don't use all that bloaty code, it does not matter if we use
> diet libc, uClibc or tomorrow's next great small libc.

Agreed.

<good argument against dynamic linking snipped>

You don't have to convince me about not really wanting dynamic linking.
As I do not know how many programs other people want in their initramfs,
or the size of these programs, I don't know if the size of a loader and
the symbol tables will outweigh the size of statically linking all of
the individual programs themselves.

It's just something to be aware of that we might have to do in the
future, that's all.  And it's nice to see that dietLibc supports this :)

> > I had asked the dietLibc authors about the ability of tweaking their
> > library into something that resembles the above, but didn't get a
> > response.
> 
> Huh?
> What email are you talking about here?

It was sent and received on the dietlibc mailing list on Jan 04, 2001.
It looks like the mailing list archive for the mailing list doesn't have
any messages for Jan, 2001, otherwise I would point you at it.  I can
forward it to you offline if you want me to.

> Before doing any real work, we need to get the specification straight.
> What exactly do we need?  The initrd stuff is too vague for my taste.
> How many programs do we want to have?  What should those programs do?
> 
> I think you need to ask initrd users.
> My understanding was that people want to use the IP autoconfiguration
> stuff from the kernel to initrd.  Is that still so?  What other programs
> are needed?

These are great questions that need to be answered.  I've started a
different topic just for it.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRCMWwB>; Tue, 13 Mar 2001 17:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRCMWvv>; Tue, 13 Mar 2001 17:51:51 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:49417 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131233AbRCMWvh>;
	Tue, 13 Mar 2001 17:51:37 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103132250.f2DMoAu426193@saturn.cs.uml.edu>
Subject: Re: system call for process information?
To: npsimons@fsmlabs.com
Date: Tue, 13 Mar 2001 17:50:10 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        g.liakhovetski@ragingbull.com (Guennadi Liakhovetski),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <20010313150235.A12677@fsmlabs.com> from "Nathan Paul Simons" at Mar 13, 2001 03:02:35 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Paul Simons writes:
> On Tue, Mar 13, 2001 at 04:05:13PM -0500, Albert D. Cahalan wrote:

>> Bloat removal: being able to run without /proc mounted.
>>
>> We don't have "kernel speed". We have kernel-mode screwing around
>> with text formatting.
>
> 	Or calculating things that really should be taken care of in
> user space, such as CPU utilization.

That can not be done reliably in user space. I know this; the "top"
program used to try.

>> This isn't just for him. Many people have wanted it.
>
> 	Yes, but how many people would actually *use* it?  How many
> programs out of the thousands out there would benefit from this?
> If it's more than 50 widely used packages, I'd be more than happy
> to see something that speeds them all up added to the kernel.

Oh please. How many programs use the mount() system call? One?
Most system calls are rarely used. This is OK.

>> 1. variable-length ASCII strings with undefined ad-hoc syntax
>
> 	Use enumerated string functions, always.
>
>> 2. array of fixed-size (64-bit) values
>
> 	It's an array?  That can still be overflowed by sloppy
> programming.

No it can't. You fill it like this:

tmp[0] = p->pid;
tmp[1] = p->uid;
/* ... */

Throw in some pretty symbolic names if you like. It's effectively
a struct, but a real struct would tempt people to use non-64-bit
values. Using an array enforces uniform 64-bit usage.

Good design involves NOT tempting people to write irregular hacks.

>  When it comes right down to it, I'd rather have
> something that could potentially die badly be run on the user
> side, rather than the kernel side.

Good. Thus you'd like the new system call in place of our
current pile of crud. Unfortunately the crud will need to
remain for at least a decade of transition time.

>> Parsing costs programmer time.
>
> 	But it's fairly easy to do in any number of programming
> languages besides C which can't be easily used in the kernel.
> Not to mention parsing libraries for C that fit much better on
> the user side because they would make the kernel huge and slow
> if compiled into it.

Huh? The kernel need not parse its own ASCII output. The kernel
natively maintains information in a binary format. The proposed
system call would not parse /proc output!!!

> 	Last but not least, I don't want to waste time in kernel
> scanning through a list of syscalls a mile long, half of them
> I don't ever use.

Well, tough luck. Learn to use an editor with search ability.
Even "less" and Netscape can search.

>  Or having a kernel that's so big that you
> can't fit it on embedded systems anymore.

The proposed system call was implemented for an embedded system.
This allowed operation without the /proc filesystem, which is
some serious bloat.

> And once you start
> adding every "nifty" syscall that comes along, that's what
> will happen.  So again, I say give us all a really good reason
> for this syscall, or just hack it into your own kernels and
> let us have our speedy, small vanilla kernels.

If you think /proc is speedy and small...




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRDXFmZ>; Tue, 24 Apr 2001 01:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132808AbRDXFmQ>; Tue, 24 Apr 2001 01:42:16 -0400
Received: from [202.54.26.202] ([202.54.26.202]:25245 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132807AbRDXFmF>;
	Tue, 24 Apr 2001 01:42:05 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Erik Paulson <epaulson@cs.wisc.edu>
cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
        linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
Message-ID: <65256A38.001DD796.00@sandesh.hss.hns.com>
Date: Tue, 24 Apr 2001 11:03:19 +0530
Subject: Re: BUG: Global FPU corruption in 2.2
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








Erik Paulson <epaulson@cs.wisc.edu> on 04/24/2001 01:14:27 AM

To:   Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
cc:   linux-kernel@vger.kernel.org, zandy@cs.wisc.edu (bcc: Amol Lad/HSS)

Subject:  Re: BUG: Global FPU corruption in 2.2




On 23 Apr 2001 18:11:48 +0200, Christian Ehrhardt wrote:
> On Thu, Apr 19, 2001 at 11:05:03AM -0500, Victor Zandy wrote:
> >
> > We have found that one of our programs can cause system-wide
> > corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
> > run this program, the FPU gives bad results to all subsequent
> > processes.
>
<...>
>
> 3.) It might be interesting to know if the problem can be triggered:
> a) If pi doesn't fork, i.e. just one process calculating pi and
> another one doing the attach/detach.

Yes, we are still able to reproduce it without calling fork (the new
program just calls
do_pi() a bunch of times, and then we attach and detach to that process)

> b) If pi doesn't do FPU Operations, i.e. only the children call do_pi.
>

You seem to need to attach and detach to a program using the fpu -
running pt on a
process that is just busy-looping over and over some integer adds does
not seem to
while running pi on the machine at the same time, but not attaching to
it does not
seem to affect the floating point state.

>>>> well... during context switching.. call to unlazy_fpu() does the following
        if (current->flags & PF_USEDFPU)
          save_fpu();

somebody earlier pointed out, for the possible race when in sys_ptrace, at the
time of attach we modify child->flags.
It really looks again strange that it is software that is causing the problem as
the code to handle FPU looks pretty clean.
still can we check current->flags when the problem occurs ?


Amol


-Erik

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





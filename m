Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284019AbRLYCS5>; Mon, 24 Dec 2001 21:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284322AbRLYCSs>; Mon, 24 Dec 2001 21:18:48 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:31748 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284019AbRLYCSm>;
	Mon, 24 Dec 2001 21:18:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Doug Ledford <dledford@redhat.com>
Cc: David Lang <david.lang@digitalinsight.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing 
In-Reply-To: Your message of "Mon, 24 Dec 2001 13:13:29 CDT."
             <3C277049.3070000@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Dec 2001 13:18:26 +1100
Message-ID: <31754.1009246706@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001 13:13:29 -0500, 
Doug Ledford <dledford@redhat.com> wrote:
>David Lang wrote:
>Since people are having such a hard time with this, let me spell it out in 
>more detail.  Assume the following scenario:
>
>Linux 2.4.17 + dynamic syscall patch.  Dynamic syscalls start at 240.
>
>Linux 2.4.18 comes out, and now there are two *new* *official* *statically* 
>*allocated* syscalls at 240 and 241 (they are SYSGETAMIBLKHEAD and 
>SYSSETAMIBLKHEAD).
>
>A new piece of software (or an existing one, doesn't matter) is written to 
>take advantage of the new syscalls.  It uses the *predefined* syscall 
>numbers and is compiled against 2.4.18.  It relies upon -ENOSYS (as is 
>typical for non-dynamic syscalls) to indicate if the kernel doesn't support 
>the intended syscalls.
>
>Now, someone without realizing the implications of what's going on, runs 
>this new program on a machine running the 2.4.17 + dynamic syscall patch.
>
>BOOM!

i386 dynamic syscall table starts at 240.  Last assigned syscall entry
is currently 225, leaving room for 14 new assigned syscalls.  2.4.0
(January 5 2001) had 222 syscalls, so 2.4 added 3 assigned syscalls in
just under a year.  At that rate the dynamic syscall range is safe for
4 years.  I make the reasonable assumption that new syscalls are
assigned monotonically, that Linus does not arbitrarily assign numbers
with gaps between them.

You can argue about whether the gap will close in 2 or 4 years.  I
suspect it will be longer than 4 years because syscall growth has been
dropping off since 2.0.

You will only get a problem when :-

* The assigned numbers reach the dynamic range _and_
* A program with an assigned syscall that overlaps the old dynamic
  range runs on a 4 year old kernel _and_
* The 4 year old kernel has the dynamic syscall patch _and_
* Some code on the 4 year old kernel is using dynamic syscalls.

A problem will only arise if _all_ of those criteria are met.  In
particular the old kernel must still be running application code that
uses dynamic syscalls, no dynamic syscalls used == no problem.

My patch is for _testing_ syscalls, not for long term use instead of
getting assigned syscall numbers.  Even if you run a brand new
application on a 4 year old kernel, you will not still be running
testing code on the old kernel.

I agree that it would be nice to have a permanently reserved dynamic
range and if my patch goes into the kernel that is exactly what I will
ask Linus for.  Even if there is no reserved dynamic range, the risk of
causing problems with new applications on old kernels is miniscule.

ps.  Bah, humbug!


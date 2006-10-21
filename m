Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWJUKzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWJUKzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 06:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWJUKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 06:55:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49323 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161198AbWJUKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 06:55:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Cal Peake" <cp@absolutedigital.net>, "Andi Kleen" <ak@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
	<m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	<m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
	<20061020075234.GA18645@flint.arm.linux.org.uk>
	<m1wt6v2gts.fsf@ebiederm.dsl.xmission.com>
	<787b0d920610200818t1950d17y10a41957fd747c63@mail.gmail.com>
Date: Sat, 21 Oct 2006 04:53:47 -0600
In-Reply-To: <787b0d920610200818t1950d17y10a41957fd747c63@mail.gmail.com>
	(Albert Cahalan's message of "Fri, 20 Oct 2006 11:18:56 -0400")
Message-ID: <m1ejt22b44.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> On 10/20/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Jakub Jelinek <jakub@redhat.com> writes:
>>
>> > This assumes the binaries and/or libraries are not stripped, and they
>> > usually are stripped.  So, it is better to run something like:
>> > find / -type f -perm /111 | while read f; do readelf -Ws $f 2>/dev/null |
> fgrep
>> > -q sysctl@GLIBC && echo $f; done
>>
>> Russell King <rmk+lkml@arm.linux.org.uk> writes:
>> > glibc on ARM _requires_ sys_sysctl for userspace ioperm, inb, outb etc
>> > emulation.
>>
>>
>> It looks like we have a small but interesting set of sysctl users.
>>
>> The list of files below is a composite from a number of systems I have
>> access to, and the reply I have gotten so far.  I'm still hoping to hear
>> from other people so I can add some other users of sysctl to my list.
>
> So does Linux now only support GLIBC apps? That's what your
> grep seems to imply. At least one of the free Pascal compilers
> does not use GLIBC. You won't find a GLIBC sysctl symbol in
> any of the alternate C libraries (there are many) or even in libc5.
>
> Running your grep on developer machines is highly biased
> against legacy business apps.

Show me a better way to prove that sysctl is used, and to
find sysctl users.

Somehow we got this idea into our heads that sysctl doesn't
matter, after we got that idea into our heads people have figured
that breaking the ABI was a don't care case.  That has got to stop.
Either by deleting the syscall or by deciding to support it.

I am attempting to take that conjecture and find the truth of it.
At first approximation the conjecture appeared true.  You compile
out sysctl and nothing obviously breaks.

Please feel free to find other means to list binaries, that use
sysctl.  Showing that there is a diversity of users, and showing that
those users use sysctl in a variety of ways is the best way to get
all of the developers to understand that sysctl isn't something
that is unused and doesn't matter.

Arguing about ABIs and user entitlements because of those ABI doesn't
put the case anywhere near as strongly as empirical evidence does.
We support and maintain ABI's because we have users, not because it is
a good in and of itself.  And our ABI currently has a mechanism to
report sysctl value is not support in this kernel, and system call is
not supported in this kernel so unless I reuse the syscall number or
the sysctl entry number I am not breaking the ABI.

I think I have found enough users to show that sysctl has users and
most likely needs to be kept.  But the list I have is currently very
small, and would benefit from a larger list of users if we can find
them.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUCEWMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbUCEWMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:12:44 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:16258 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261226AbUCEWMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:12:41 -0500
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<200403031829.41394.mmazur@kernel.pl>
	<m3brnc8zun.fsf@defiant.pm.waw.pl>
	<200403042149.36604.mmazur@kernel.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 05 Mar 2004 18:02:25 +0100
In-Reply-To: <200403042149.36604.mmazur@kernel.pl> (Mariusz Mazur's message
 of "Thu, 4 Mar 2004 21:49:36 +0100")
Message-ID: <m3brnb8bxa.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur <mmazur@kernel.pl> writes:

> I never said kernel should require glibc - it shouldn't (mind you I don't do 
> kernelland headers). But kernel does duplicate each and every structure 
> provided by glibc. It has to.

No, there is no such requirement. Glibc doesn't need to duplicate kernel
defs either.

Do you really want duplicated code (definitions etc)?

> The Bad Thing (tm) is that all (well... allmost 
> all - lots of linux headers don't parse correctly in userspace)

That's bad, for sure.

> of those 
> structures get exported to userland. And programmers use them. They don't 
> include <sys/resource.h>, but <linux/resource.h>. And that causes conflicts 
> (and is bad practice).

So the kernel headers are buggy (and should be fixed) and the glibc
headers contain unneeded code (and they should be fixed as well).

>> IMHO all the defines should be in the kernel tree. Glibc can and should
>> use them, as it uses the ABI.
>
> Parts of abi that are standardized 
> (http://www.opengroup.org/onlinepubs/007904975/ - this thing; check the 
> headers section), should be imho provided by C libs.

The C library alone obviously provide some functionality such as string.h
functions and such API should be defined in glibc headers.
However, a part of the glibc (or any libc) functionality is provided by
the kernel itself. It is still correct to say that those are provided
by libc, and that this is libc providing the headers. It doesn't mean
the syscalls can't go straight to the kernel and that the libc
headers can't just include/be the kernel ones.

> These things do not 
> change (they can't or everything would blow up) and I see no reason why glibc 
> should rely on having additional headers available, just to do what it's 
> supposed to.

Because glibc has to rely on underlying kernel services while the user
space programs are executed.

You know, Linux can be run on different architectures. Do you want to
keep different sets of header files for each arch? Yes, the APIs differs.

BTW: the user space programs don't necessarily need glibc. They may need
the kernel API headers, of course.
You may even want to use another C library. Would you copy the headers
in such case again?

> Userland headers should be kept in /usr/include/{asm,linux}.

Because?

> As to linux-common linux-kernelonly and linux-userland headers (linux-common 
> used by both) - I just find it weird for userland to require kernel sources. 
> Linux is supposed to have stable abi.

No, it isn't. It's supposed to have a backward-compatible ABI.
You don't want to block progress, do you?

However, this isn't only about progress. A functionality can be removed,
too.

>> Examples?
>> If they are part of kernel API/ABI, then of course they are still used
>> by 2.6 kernel and they need to be there. If they aren't used by the
>> kernel (old #define names for instance) they should go to glibc headers
>> (#ifndef xxx #define xxx etc.).
>
> Additionall defines mostly. Probably some extra structures.

I'd go with the above, then.
-- 
Krzysztof Halasa, B*FH

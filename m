Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWJXVBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWJXVBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWJXVBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:01:08 -0400
Received: from [87.201.200.205] ([87.201.200.205]:5333 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S965198AbWJXVBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:01:06 -0400
Message-ID: <453E7F07.9010804@0Bits.COM>
Date: Wed, 25 Oct 2006 01:00:55 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20061017)
MIME-Version: 1.0
To: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've definetly not done any such change on my machine. Remember with the 
same compile, same environment, if i go back to 2.6.18 i can build uml 
fine. If i move to 2.6.18.1 or above it breaks...

I do notice my gcc stddef does have this defined

% grep offsetof /usr/lib/gcc/i686-linux/4.0.3/include/stddef.h
#define offsetof(TYPE, MEMBER) __builtin_offsetof (TYPE, MEMBER)

And i notice my compiler has it inbuilt, so maybe this is a gcc 4.0.3 
issue ?

% strings /usr/libexec/gcc/i686-linux/4.0.3/cc1|grep offsetof
offsetof_member_designator
__builtin_offsetof
fold_offsetof_1
-Winvalid-offsetof
Warn about invalid uses of the "offsetof" macro


-------- Original Message --------
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Date: Tue, 24 Oct 2006 09:20:25 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <453DC147.2020508@0Bits.COM>

On Tue, Oct 24, 2006 at 11:31:19AM +0400, Mitch wrote:
> I'm still having build failures on 2.6.18.1 and even the latest -rc3
> 
> home /usr/src/sources/kernel/linux-2.6.18% !ma
> make ARCH=um
>   SYMLINK arch/um/include/kern_constants.h
>   CC      arch/um/sys-i386/user-offsets.s
> arch/um/sys-i386/user-offsets.c: In function 'foo':
> arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of 
> function 'offsetof'

The last time I saw this, someone had replaced the glibc kernel
headers with a link to include/ within a kernel pool.  There, offsetof
is wrapped in #ifdef __KERNEL__, and inaccessible to userspace.

The glibc headers have a usable offsetof, so fix that, and UML should
build.

				Jeff

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbRGNSFC>; Sat, 14 Jul 2001 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbRGNSEv>; Sat, 14 Jul 2001 14:04:51 -0400
Received: from geos.coastside.net ([207.213.212.4]:51673 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S264632AbRGNSEh>; Sat, 14 Jul 2001 14:04:37 -0400
Mime-Version: 1.0
Message-Id: <p05100309b77639cfaced@[207.213.214.37]>
In-Reply-To: <3B5083AE.71515696@mandrakesoft.com>
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu>
 <3B5083AE.71515696@mandrakesoft.com>
Date: Sat, 14 Jul 2001 11:04:27 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: __KERNEL__ removal
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:38 PM -0400 2001-07-14, Jeff Garzik wrote:
>Alan Cox wrote:
>>  Jeff Garzik wrote:
>>  > it would be nice to remove __KERNEL__ from at least the i386
>>  > kernel headers in 2.5, and I think it's a doable task...
>>
>>  That just generates work for the glibc folks when they are working 
>>off copies
>>  of kernel header snapshots as they need to
>
>It is a flag day change so it generates [a lot of] work once... it has
>always been policy that userspace shouldn't be including kernel
>headers.  uClibc and now dietlibc are following this policy.
>
>IMHO we have made an exception for glibc for long enough...

I take it the policy JG is referring to applies to including any 
kernel header files at all in userspace programs, and that __KERNEL__ 
removal is a mere consequence of that policy.

AC points out that syscall interfaces in glibc are a reasonable 
exception to that policy.

What about a header like ethtool.h? Isn't its whole reason for 
existing to provide a common ABI for ethtool.c and the various 
drivers that support it?

Likewise sockios.h, which ethtool (and no doubt many others) also 
#includes. Unless you're going to encapsulate all possible ioctl 
interfaces into libc, sockios.h (for example) provides a piece of the 
ABI that's needed by the user code, not just by libc. Why would it 
make sense to require retyping of this stuff?

If, on the other hand, the argument is that user-kernel ABI 
definitions should be isolated in their own headers, and not mixed up 
(hence __KERNEL__), that's a much more restricted argument. My 
impression is that this is *not* the argument though; is it?
-- 
/Jonathan Lundell.

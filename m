Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbVICFzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbVICFzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbVICFzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:55:32 -0400
Received: from smtpout.mac.com ([17.250.248.97]:5343 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161152AbVICFza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:55:30 -0400
In-Reply-To: <20050903042859.GA30101@codepoet.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 01:55:17 -0400
To: andersen@codepoet.org
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 3, 2005, at 00:28:59, Erik Andersen wrote:
>> Absolutely not.  This would be a POSIX namespace violation; they
>> *must* use double-underscore types.
>
> I assume you are worried about the stuff under asm that ends up
> being included by nearly every header file in the world.  Of
> course asm must use double-underscore types.  But the thing is,
> the vast majority of the kernel headers live under
> linux/include/linux/ and do not use double-underscore types, they
> use kernel specific, non-underscored types such as s8, u32, etc.
> My copy of IEEE 1003.1 and my copy of ISO/IEC 9899:1999 both fail
> to prohibit using the shiny new ISO C99 type for the various
> #include <linux/*> header files, which is what I was suggesting.

Anything in linux/* that is included by userspace should not
presume that stdint.h has already been included or include it on
its own, because the userspace program may have already made its
own definitions of uint32_t, or it may not want them defined at
all.

> The world would be so much nicer a place if user space were free
> to #include linux/* header files rather than keeping a
> per-project private copy of all kernel structs of interest.

Exactly!  This is why I want to create kcore/* and kabi/* that
define the appropriate types, then both userspace and the kernel
could use whatever types fit their fancy, defined in terms of the
__kcore_ and __kabi_ types, which could be _depended_ on to exist
because they are guaranteed not to conflict with other namespaces

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at
it in the right way, did not become still more complicated.
   -- Poul Anderson




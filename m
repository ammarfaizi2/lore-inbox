Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286215AbSALNRT>; Sat, 12 Jan 2002 08:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbSALNRJ>; Sat, 12 Jan 2002 08:17:09 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:31154 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S286215AbSALNQ5>; Sat, 12 Jan 2002 08:16:57 -0500
Message-ID: <3C40378B.583AC9E3@didntduck.org>
Date: Sat, 12 Jan 2002 08:18:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: hpa@transmeta.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <200201121048.CAA11276@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> H. Peter Anvin wrote, in response to Andi Kleen:
> >You don't need CMPXCHG8B to do efficient inline mutexes.  In fact, the
> >pthreads code for i386 uses the same mutexes the kernel does (LOCK INC
> >based, I believe), complete with section hacking to make them
> >efficiently inlinable -- and then they're put inside a function call.
> [...]
> 
>         Your comment prompted me to look at
> linux-2.5.2-pre11/include/asm-i386/spinlock.h, and I now believe that
> the "lock; decb" that it uses for grabbing spinlocks will return an
> incorrect success if 255 or more processors are waiting on the same
> spinlock.

Implementation detail.  You could just as easily use a long instead of a
char and have room for 2^32 processors.

--
						Brian Gerst

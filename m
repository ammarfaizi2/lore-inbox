Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272295AbRIVV5C>; Sat, 22 Sep 2001 17:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272304AbRIVV4v>; Sat, 22 Sep 2001 17:56:51 -0400
Received: from [24.254.60.34] ([24.254.60.34]:10954 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272295AbRIVV4g>; Sat, 22 Sep 2001 17:56:36 -0400
Message-ID: <3BAD0A43.731832F4@didntduck.org>
Date: Sat, 22 Sep 2001 18:01:39 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
CC: linux-kernel@vger.kernel.org, linux-vax@mithra.physics.montana.edu
Subject: Re: Global Offset Table question..
In-Reply-To: <Pine.LNX.4.32.0109222139550.22558-100000@skynet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> 
> I've been trying to get dynamic loading on the Linux/VAX project going,
> and I've having trouble with the Global Offset Table and how it magically
> gets in to the ebx register on x86.. where is this done?
> 
> I think I've looked at the kernel, gcc, binutils, ld.so 1.9, glibc 2.2.3
> and can't see exactly where this happens...
> 
> Anyone care to enlighten my poor brain...
> 
> Thanks,
>         Dave.
> 

I assume you are talking about position independant code?  On the x86,
the only instructions that can use IP-relative addressing are branch
instructions.  This asm fragment shows how it's done:

	call 1f
1:	popl %ebx
	addl $(GOT - 1b), %ebx

If the Vax has better support for IP-relative addressing, this may be
easier.  On recent x86 procesors, the above code will screw up the
call/return cache (branch prediction) and cause performance penalties.

--
					Brian Gerst

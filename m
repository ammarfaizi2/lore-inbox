Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131196AbQKADws>; Tue, 31 Oct 2000 22:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbQKADwj>; Tue, 31 Oct 2000 22:52:39 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:26103
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S131196AbQKADwa>; Tue, 31 Oct 2000 22:52:30 -0500
From: Jesse Pollard <pollard@cats-chateau.net>
Reply-To: pollard@cats-chateau.net
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Date: Tue, 31 Oct 2000 21:42:13 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011010133.eA11Xtr11638@sleipnir.valparaiso.cl>
In-Reply-To: <200011010133.eA11Xtr11638@sleipnir.valparaiso.cl>
MIME-Version: 1.0
Message-Id: <00103121504302.20791@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Horst von Brand wrote:
>Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> said:
>
>[...]
>
>> Also pay attention to the security aspects of a true "zero copy" TCP stack.
>> It means that SOMETIMES a user buffer will recieve data that is destined
>> for a different process.
>
>Why? AFAIKS, given proper handling of the issues involved, this can't
>happen (sure can get tricky, but can be done in principle. Or am I
>off-base?)

As I understand the current implementation, this can't. One of the optimizations
I had read about (for a linux test) used zero copy to/from user buffer as well
as zero copy in the kernel. I believe the DMA went directly to the users memory.

This causes a problem when/if there is a context switch before the data is
actually transferred to the proper location. The buffer isn't ready for use,
but could be examined by the user application (hence the security problem).

It was posed that this is not a problem IF the cluster (and it was a beowulf
cluster under discussion) is operated in a single user, dedicated mode.
In which case, to examine the buffer would either be a bug in the program,
or a debugger looking at a buffer directly.

To my knowlege, zero copy is only done to/from device and kernel. Userspace
has to go through a buffer copy (one into user space; one output from user
space) for all IP handling. All checksums are either done by the device,
or done without copying the data.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@cats-chateau.net

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbRGJT1R>; Tue, 10 Jul 2001 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbRGJT1I>; Tue, 10 Jul 2001 15:27:08 -0400
Received: from geos.coastside.net ([207.213.212.4]:56994 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267103AbRGJT04>; Tue, 10 Jul 2001 15:26:56 -0400
Mime-Version: 1.0
Message-Id: <p0510031cb77103632663@[207.213.214.37]>
In-Reply-To: <Pine.LNX.3.95.1010710142459.19170A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010710142459.19170A-100000@chaos.analogic.com>
Date: Tue, 10 Jul 2001 12:26:39 -0700
To: root@chaos.analogic.com
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:45 PM -0400 2001-07-10, Richard B. Johnson wrote:
>  > AT&T days that there were Unix ports with separate kernel (vs user)
>>  address spaces, as well as processors with special instructions for
>
>No. The difference between kernel and user address space is protection.
>Let's say that you decided to revamp all the user space to go from
>0 to 2^32-1. You call the kernel with a pointer to a buffer into
>which you need to write kernel data:
>
>You will need to set a selector that will access both user and
>kernel data at the same time. Since the user address space is
>paged, this will not be possible, you get one or the other, but
>not both. Therefore, you need to use two selectors. In the case
>of ix86 stuff, you could set DS = KERNEL_DS and ES = a separately
>calculated selector that represents the base address of the caller's
>virtual address space. Note that you can't just use the caller's
>DS or ES because they can be changed by the caller.

Sure, for IA-32, it's a royal pain. But Unix runs, after all, on 
other CPUs. In point of simple historical fact, there have been Unix 
ports with separate kernel and user address spaces, and there are 
CPUs that, unlike IA-32, can simultaneously address the two spaces, 
by virtue of having separate page table pointers and instructions for 
copying between the two spaces.

To the extent that we're talking about Linux on IA-32, though, I 
entirely agree that the cost of expanding user space from 3GB to 4GB 
far outweighs any benefit. Especially with 64-bit architectures 
coming online.
-- 
/Jonathan Lundell.

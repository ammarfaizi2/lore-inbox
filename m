Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288709AbSAICBs>; Tue, 8 Jan 2002 21:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288711AbSAICBi>; Tue, 8 Jan 2002 21:01:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:57352 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288709AbSAICBW>; Tue, 8 Jan 2002 21:01:22 -0500
Message-ID: <3C3BA330.729B06FE@zip.com.au>
Date: Tue, 08 Jan 2002 17:56:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam McKenna <adam-dated-1010972538.f82778@flounder.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filesystem creation problems with 2.4.17
In-Reply-To: <20020109014216.GB4511@flounder.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam McKenna wrote:
> 
> I'm having some problems creating a large filesystem on linux kernels
> 2.4.17.  I am using Debian Potato with Adrian Bunk's updates for
> running 2.4.  The filesystem is approx. 260GB and is on an AMI MegaRAID
> RAID-5 stripe.
> 
> ...
> write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768)
> = -1 EFBIG (File too large)
> --- SIGXFSZ (File size limit exceeded) ---
> +++ killed by SIGXFSZ +++

Kernel bug.  Apply this patch:

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa1/00_blkdev-ulimit-1

Or run mke2fs from a fresh root login (not via `su')
or fiddle with ulimit to set it unlimited.

-

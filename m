Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265919AbSKBK0K>; Sat, 2 Nov 2002 05:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265920AbSKBK0K>; Sat, 2 Nov 2002 05:26:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:22188 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265919AbSKBK0J>;
	Sat, 2 Nov 2002 05:26:09 -0500
Message-ID: <3DC3A9C0.7979C276@digeo.com>
Date: Sat, 02 Nov 2002 02:32:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Akira Tsukamoto <at541@columbia.edu>
CC: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
References: <20021102025838.220E.AT541@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 10:32:32.0943 (UTC) FILETIME=[2719C3F0:01C2825B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Tsukamoto wrote:
> 
> This consists mainly of the optimized copy routine for PIII/P4.
> 
> It is basically identical to what was introduced in 2.5.45.

But you've inlined them again.  Your patches increase my kernel
size by 17 kbytes, which is larger than my entire Layer 1 instruction
cache!

I'd prefer that we have these functions in .c, and laid out with
a minimum of C tricks.  Because more work needs to be done on the
memory copy functions, and doing that in header files is a pain.
(That is, using the movnta instructions for well-aligned copies
and clears so that we don't read the destination memory while overwriting
it).

Hopefully, yes, we can end up removing the runtime-selectable alignment
mask.  I left that in at present because it provides the infrastructure
for making other runtime-selectable decisions about how to perform
copies and clears.  Distributors like to be able to ship a minimum
number of kernels (say, just a PII-compiled kernel) and we want those
to run as well as possible on PIII and P4.

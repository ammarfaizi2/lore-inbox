Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUB1AhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbUB1AhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:37:05 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:51612 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263215AbUB1AhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:37:01 -0500
Subject: Re: [patch] u64 casts
From: Albert Cahalan <albert@users.sf.net>
To: davidm@hpl.hp.com
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <16447.56941.774257.925722@napali.hpl.hp.com>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077920213.2233.44.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Feb 2004 17:16:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 19:18, David Mosberger wrote:
> >>>>> On 27 Feb 2004 15:58:42 -0500, Albert Cahalan <albert@users.sourceforge.net> said:
> 
>   Albert> Casts are considered harmful, because they bypass
>   Albert> type checking, but how do you print a u64 value?
>   Albert> You cast it to "unsigned long long" like this:
> 
>   Albert> printk("%llu\n", (unsigned long long)foo);
> 
>   Albert> Well, this is silly and ugly. As x86-64 has shown,
>   Albert> even a 64-bit port can use "long long" for 64-bit
>   Albert> values. This patch changes all other 64-bit ports.
>   Albert> It now becomes possible to avoid adding new casts
>   Albert> all over the place; existing ones may be removed
>   Albert> if so desired.
> 
> Did you verify that none of the kernel header files that are still
> being used by glibc contain declarations based on __u64 or __s64?  If
> not, your patch breaks user-level code.

Supposing that this is the case, you may get warnings.
Well, good, maybe somebody will fix glibc. The data
types are obviously the same size, so no data-corrupting
errors will result.

Note that x86-64, a 64-bit port using glibc, is just
fine with "long long" already.

Also note that /usr/include/asm is a modified copy of
kernel headers. It won't be suddenly changing as a
result of the patch, even after a kernel upgrade.
(the symlink hasn't been OK since libc5 days)



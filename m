Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWBVVya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWBVVya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWBVVya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:54:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55775
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750748AbWBVVya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:54:30 -0500
Date: Wed, 22 Feb 2006 13:54:30 -0800 (PST)
Message-Id: <20060222.135430.44726149.davem@davemloft.net>
To: hpa@zytor.com
Cc: klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43FCDB8A.5060100@zytor.com>
References: <43FCDB8A.5060100@zytor.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 22 Feb 2006 13:45:46 -0800

> I've looked through the code for sys_mmap2 on several architectures, and 
> it looks like some architectures plays by the "shift is always 12" rule, 
>   e.g. SPARC, and some expect userspace to actually obtain the page 
> size, e.g. PowerPC and MIPS.  On some architectures, e.g. x86 and ARM, 
> the point is moot since PAGE_SIZE is always 2^12.
> 
> a. Is this correct, or have I misunderstood the code?
> 
> b. If so, is this right, or is this a bug?  Right now both klibc and 
> µClibc consider the latter a bug.
> 
> c. Which architectures are affected which way?

Right.

On sparc32 we had the issue where we had a 8K page size
platform (sun4) and the rest were using 4K page size.

I can't even think why we do that fixed shift actually.  I think Jakub
Jalinek thought this might be a way to make applications assuming
4K page size work on the 8K page size machines.

I'm going to say that you can feel free to fix this to use PAGE_SHIFT
correctly all the time.  Applications should be calling getpagesize()
and not assume what that value might be.

Please double check that we report the correct page size to userspace
and not a fixed 4K value :-)

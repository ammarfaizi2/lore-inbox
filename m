Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293245AbSCAQ25>; Fri, 1 Mar 2002 11:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293217AbSCAQ2k>; Fri, 1 Mar 2002 11:28:40 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:55543 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293256AbSCAQ2I>; Fri, 1 Mar 2002 11:28:08 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020301.074940.54789154.davem@redhat.com> 
In-Reply-To: <20020301.074940.54789154.davem@redhat.com>  <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com> <22820.1014996781@redhat.com> <23330.1014997061@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 16:28:04 +0000
Message-ID: <29409.1015000084@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  Sorry, use an inline instead.

Thanks - that works, with a slight modification:

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,5)
#include <linux/sched.h>
static inline void __recalc_sigpending(void)
{
	recalc_sigpending(current);
}
#define recalc_sigpending() __recalc_sigpending ()
#endif

The goal is to have code that just works in 2.5 without compat crap like
jffs2_recalc_sigpending, and to fix it up in the headers only for older
kernels. Most of the changes in 2.5 (and indeed 2.4) have been done in a way
that makes such an approach feasible. 

I had been assuming this was intentional good design; perhaps it was just a
fluke. 

--
dwmw2


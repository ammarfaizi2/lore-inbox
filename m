Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbTGUXgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 19:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270758AbTGUXgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 19:36:18 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:21684 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S270757AbTGUXgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 19:36:15 -0400
Date: Tue, 22 Jul 2003 09:51:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kurt Roeckx <Q@ping.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: siginfo pad problem.
Message-Id: <20030722095105.5ed2379a.sfr@canb.auug.org.au>
In-Reply-To: <20030721180032.GA26786@ping.be>
References: <20030721142259.GA4315@ping.be>
	<20030722022424.7480af8e.sfr@canb.auug.org.au>
	<20030721180032.GA26786@ping.be>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,

On Mon, 21 Jul 2003 20:00:32 +0200 Kurt Roeckx <Q@ping.be> wrote:
>
> linux/types.h has:
> #ifdef __KERNEL__
> typedef __kernel_uid32_t        uid_t;
> #else
> typedef __kernel_uid_t          uid_t;
> #endif /* __KERNEL__ */
> 
> And __kernel_uid_t is an "unsigned short"

Anywhere this should be used (i.e. only in the kernel), uid_t will be
__kernel_uid32_t.  The change to this part of the siginfo_t structure has
not yet propogated to the glibc headers and when it does, it is up to the
glibc maintainers to make sure it matches what is used inside the kernel.

My extrapolation of your point leads me to ask why we even bother
with __KERNEL__ in the kernel's header files anymore since we keep
telling people that user mode programs should not use the kernel's
header files.

You are right that if a user mode program include the kernel's siginfo.h
(without defining __KERNEL__) it will not compile (on those architectures
where __kernel_uid_t is "unsigned short") but the answer I keep seeing
from this list is "Don't do that".

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

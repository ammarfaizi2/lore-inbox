Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUFHCvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUFHCvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 22:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUFHCvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 22:51:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:60606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265161AbUFHCu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 22:50:59 -0400
Date: Mon, 7 Jun 2004 19:50:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, zwane@linuxpower.ca,
       wli@holomorphy.com
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-Id: <20040607195011.34f8e84e.akpm@osdl.org>
In-Reply-To: <20040607214034.27475.qmail@web51807.mail.yahoo.com>
References: <200406080712.44759.kernel@kolivas.org>
	<20040607214034.27475.qmail@web51807.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab <phyprabab@yahoo.com> wrote:
>
> Also please note the degredation between
>  2.6.7-rc2-bk8-s63:
> 
>  A:  35.57user 38.18system 1:20.28elapsed 91%CPU
>  B:  35.54user 38.40system 1:19.48elapsed 93%CPU
>  C:  35.48user 38.28system 1:20.94elapsed 91%CPU
> 
>  Interesting how much more time is spent in both user
>  and kernel space between the two kernels.  Also note
>  that 2.4.x exhibits even greater delta:
> 
>  A:  28.32user 29.51system 1:01.17elapsed 93%CPU
>  B:  28.54user 29.40system 1:01.48elapsed 92%CPU
>  B:  28.23user 28.80system 1:00.21elapsed 94%CPU
> 
>  Could anyone suggest a way to understand why the
>  difference between the 2.6 kernels and the 2.4
>  kernels?

This is very very bad.

It's a uniprocessor machine, yes?

Could you describe the workload a bit more?  Is it something which others
can get their hands on?

It spends a lot of time in the kernel for a build system.  I wonder why.

At a guess I'd say either a) you're hitting some path in the kernel which
is going for a giant and bogus romp through memory, trashing CPU caches or
b) your workload really dislikes run-child-first-after-fork or c) the page
allocator is serving up pages which your access pattern dislikes or d)
something else.

It's certainly interesting.

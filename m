Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTILQKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTILQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:10:32 -0400
Received: from masmail.mascorp.com ([65.205.206.168]:23819 "EHLO
	masmail.mascorp.com") by vger.kernel.org with ESMTP id S261741AbTILQK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:10:26 -0400
Subject: Re: Memory mapped IO vs Port IO
From: Anthony Dominic Truong <anthony.truong@mascorp.com>
To: linux-kernel@vger.kernel.org
Cc: Jamie Lokier <jamie@shareable.org>, willy@debian.org
In-Reply-To: <20030911192550.7dfaf08c.ak@suse.de>
References: <20030911192550.7dfaf08c.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1063308053.4430.37.camel@huykhoi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Sep 2003 09:10:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-11 at 10:25, Andi Kleen wrote:
> On Thu, 11 Sep 2003 18:12:05 +0100
> Jamie Lokier <jamie@shareable.org> wrote:
> 
> > Andi Kleen wrote:
> > > Even a memory write is tens to hundres of cycles.
> > 
> > Not from the CPU's perspective.  It is done in parallel with other
> > instructions.
> 
> Only when there are more instructions to execute. But device
> driver code often does a following read e.g. to check if it can submit
> another request to the hardware.
> 
> My claim is basically:
> 
> Change everybody who currently does
> 
> #ifdef CONFIG_MMIO
>         writel(... )
>         readl(...)
> #else
>         outl( ... ) 
>         inl ( ...) 
> #endif
> 
> to 
>         if (dev->mmio) { 
>                 writel(); 
>                 real();
>         } else { 
>                 outl();
>                 inl();
>         } 
> 
> and you will have a hard time to benchmark the difference on any non
> ancient system
> in actual driver operation.
> 
> -Andi
> 
Hello,
Wouldn't it be better if we set the IN and OUT function pointers to the
right functions during driver init. based on the setting of dev->mmio.
And throughout the driver, we just call the IN and OUT functions by
their pointers.  Then we don't have to do if (dev->mmio) every time.
It's similar to the concept of virtual member function in C++.

ADT


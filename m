Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288667AbSANCTy>; Sun, 13 Jan 2002 21:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288668AbSANCTj>; Sun, 13 Jan 2002 21:19:39 -0500
Received: from [202.135.142.194] ([202.135.142.194]:34062 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288667AbSANCTQ>; Sun, 13 Jan 2002 21:19:16 -0500
Date: Mon, 14 Jan 2002 13:19:25 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: cross-cpu balancing with the new scheduler
Message-Id: <20020114131925.4fcbd127.rusty@rustcorp.com.au>
In-Reply-To: <3C41BD74.28F6707A@colorfullife.com>
In-Reply-To: <3C41BD74.28F6707A@colorfullife.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 18:01:40 +0100
Manfred Spraul <manfred@colorfullife.com> wrote:

> Is it possible that the inter-cpu balancing is broken in 2.5.2-pre11?
> 
> eatcpu is a simple cpu hog ("for(;;);"). Dual CPU i386.
> 
> $nice -19 ./eatcpu&;
>  <wait>
> $nice -19 ./eatcpu&;
>  <wait>
> $./eatcpu&.
> 
> IMHO it should be
> * both niced process run on one cpu.
> * the non-niced process runs with a 100% timeslice.
> 
> But it's the other way around:
> One niced process runs with 100%. The non-niced process with 50%, and
> the second niced process with 50%.

This could be fixed by making "nr_running" closer to a "priority sum".

Ingo?

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319078AbSH2C0A>; Wed, 28 Aug 2002 22:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSH2CZ7>; Wed, 28 Aug 2002 22:25:59 -0400
Received: from dp.samba.org ([66.70.73.150]:42883 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319078AbSH2CZ5>;
	Wed, 28 Aug 2002 22:25:57 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.32-mm1 
In-reply-to: Your message of "Wed, 28 Aug 2002 09:47:19 MST."
             <3D6CFE97.DA554FA9@zip.com.au> 
Date: Thu, 29 Aug 2002 11:20:57 +1000
Message-Id: <20020828213041.13C3F2C0F7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D6CFE97.DA554FA9@zip.com.au> you write:
> Heinz Diehl wrote:
> > 
> > ...
> > fs/fs.o(.text+0x5932): undefined reference to cpu_possible'
> 
> Bah.  Sorry about that.  cpu_possible() appears to be undefined
> for uniprocessor builds.

Yes.

> +
> +#define cpu_possible(cpu)	((cpu) == 0)
> +

This is fine: techically it's:
	BUG_ON(cpu != 0);

Since you can never invoke cpu_possible(cpu) or cpu_online(cpu) for
cpu >= NR_CPUS.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbTGJKro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbTGJKro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:47:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64929 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269187AbTGJKrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:47:43 -0400
Date: Thu, 10 Jul 2003 12:59:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more)
 support
In-Reply-To: <200307101450.42340.dev@sw.ru>
Message-ID: <Pine.LNX.4.44.0307101248480.5443-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jul 2003, Kirill Korotaev wrote:

> > yes, it is also visible to user-space, otherwise user-space LDT
> > descriptors would not work. The top 16 MB of virtual memory also hosts the
> > 'virtual LDT'.
> > the top 16 MB is split up into per-CPU areas, each CPU has its own. Check
> > out atomic_kmap.h for details.

> But you need to remap it every time a switch occurs. [...]

only if the task uses an LDT - which with NPTL is very rare these days.  
But _if_ something relies on LDTs heavily then it can be done limit-less.
(we used to have nasty LDT limits due to vmalloc() limitations).

> 8. NMI is special. The only difference is that unlike usual interrupts
> NMI can interrupt returning to user-space either. This is solved easily
> by saving current cr3/esp on enter and restoring them if required on
> leave ("required"  == esp >= 0xffxxxxxx).

ok, "esp >= 0xff000000" is a good check, and it's a constant check so it
can be done very early in the entry code. The double-cr3-load is not an
issue, this is a rare race situation. I'll rework this area to be faster,
but first i wanted to concentrate on robustness. Thanks for you comments,
they are really useful!

	Ingo


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262889AbSJRD37>; Thu, 17 Oct 2002 23:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262892AbSJRD37>; Thu, 17 Oct 2002 23:29:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:17848 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262889AbSJRD36>;
	Thu, 17 Oct 2002 23:29:58 -0400
Message-ID: <3DAF8198.A66E0C82@digeo.com>
Date: Thu, 17 Oct 2002 20:35:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 still not testable by end users
References: <3DAE2691.76F83D1B@digeo.com>
		<Pine.LNX.4.44.0210171717550.18123-100000@dad.molina>
		<3DAF3C36.2065CFD1@digeo.com> <m3smz4o415.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2002 03:35:52.0419 (UTC) FILETIME=[756E4B30:01C27657]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@digeo.com> writes:
> >
> > request_irq() needs to take the allocation mode as an argument.
> > Should always have.  Sigh.  I'll fix it up sometime.
> 
> If you change it I would change it to let the caller pass it in. Then
> it's explicit and most drivers can just slab it somewhere in their
> private structures without any allocation.
> 

Well that would require that the drivers become aware of struct irqaction,
and make assumptions about how the particular arch handles interrupts.

But it's a bit academic.  ia32's request_irq() calls proc_mkdir() and
create_proc_entry().  So there's no point in feeding gfp_flags down
into request_irq or whatever.  We need to fix IDE still.

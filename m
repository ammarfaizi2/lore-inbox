Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264577AbSIVWgj>; Sun, 22 Sep 2002 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264580AbSIVWgj>; Sun, 22 Sep 2002 18:36:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19360 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264577AbSIVWgi>;
	Sun, 22 Sep 2002 18:36:38 -0400
Date: Mon, 23 Sep 2002 00:50:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <3D8E3FA9.7389A61F@opersys.com>
Message-ID: <Pine.LNX.4.44.0209230032350.28641-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a number of suggestions to make the tracer truly lightweight:

 - remove the 'event registration' and callback stuff. It just introduces
   unnecessery runtime overhead. Use an include file as a registry of
   events instead. This will simplify things greatly. Why do you need a
   table of callbacks registered to an event? Nothing in your patches
   actually uses it ... Just use one tracing function that copies the
   arguments into a per-CPU ringbuffer. It's really just a few lines.

 - do not disable interrupts when writing events. I used this method in
   a tracer and it works well. Just get an irq-safe index to the trace
   ring-buffer and fill it in. [eg. on x86 incl can be used for this
   purpose.]

 - get rid of p->trace_info and the pending_write_count - it's completely
   unnecessery.

 - drivers/trace/tracer.c is a complex mess of strange coding style and
   #ifdefs, it's not proper Linux kernel code.

it's possible to have lightweight tracing - this patch clearly is not
achieving that goal yet.

	Ingo


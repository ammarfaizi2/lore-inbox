Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289837AbSAWM7F>; Wed, 23 Jan 2002 07:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAWM66>; Wed, 23 Jan 2002 07:58:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56270 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289837AbSAWM6q>;
	Wed, 23 Jan 2002 07:58:46 -0500
Date: Wed, 23 Jan 2002 15:56:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre2-3 SMP broken on UP boxen
In-Reply-To: <Pine.LNX.4.44.0201231357480.12928-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0201231555100.2467-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jan 2002, Zwane Mwaikambo wrote:

> 	My test box is a single proc machine running an SMP kernel. As of
> 2.5.2-pre2 it panics on boot. The reason is kinda obvious,
> smp_processor_id() will always return the same as global_irq_holder.
> How come we do this check now?

Al found the bug, in smpboot.c:

-        global_irq_holder = 0;
+        global_irq_holder = NO_PROC_ID;

does this fix it?

	Ingo


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSI1SVP>; Sat, 28 Sep 2002 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSI1SVP>; Sat, 28 Sep 2002 14:21:15 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:65160 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262295AbSI1SVO>; Sat, 28 Sep 2002 14:21:14 -0400
Date: Sat, 28 Sep 2002 20:26:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: davidm@hpl.hp.com
cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: show_stack()/show_trace() prototypes
In-Reply-To: <200209281642.g8SGgKMA007827@napali.hpl.hp.com>
Message-ID: <Pine.GSO.3.96.1020928202321.10698A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002, David Mosberger wrote:

> Ingo, the ksymoops patch adds these to linux/sched.h:
> 
> extern void show_trace(unsigned long *stack);
> extern void show_stack(unsigned long *stack);
> 
> This is not good.  In general, it is not possible to do a reliable
> backtrace with just a stack pointer as a starting point (it is
> necessary to have access to the entire "preserved" machine state
> instead).  I'd suggest to either change the argument to a task_struct
> pointer (and update half a dozen platforms or so accordingly), or to
> leave the declarations platform-specific like they were before.

 Also the prototypes may differ, e.g. for MIPS/MIPS64 we have:

extern void show_trace(long *stack);

since MIPS addresses are signed and then, for consistency, we have:

extern void show_stack(long *stack);

as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSBYVG5>; Mon, 25 Feb 2002 16:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292187AbSBYVGo>; Mon, 25 Feb 2002 16:06:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14845 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288748AbSBYVGL>; Mon, 25 Feb 2002 16:06:11 -0500
Message-ID: <3C7AA727.316EC197@mvista.com>
Date: Mon, 25 Feb 2002 13:05:43 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Universal Regs address 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

&regs is needed by the deliver signal code and currently is supplied by
the system call interface to the system calls that need it.  This
requires that any new system call to have (at least in some archs)
special code in the system call trap area to pass the &regs, or does it?

In an arch in which the call stack address decreases as calls are made,
isn't:

&regs = stack_base+size of(stack) - size of(struct regs);

an for stacks that increase:

&regs = stack_base;

The only time this would not be true, unless I am missing something, is
if the system call is made from kernel space.  Is this an issue?  Do we
ever need &regs if called from the kernel?  If not, can we tell the call
was from the kernel?

comments?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/

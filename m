Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVBJVFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVBJVFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVBJVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:05:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:65523 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261879AbVBJVFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:05:35 -0500
Message-ID: <420BCC9C.8080807@mvista.com>
Date: Thu, 10 Feb 2005 13:05:32 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: William Weston <weston@lysdexia.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org> <20050210075234.GC9436@elte.hu> <420BC23F.6030308@mvista.com> <20050210204031.GA17260@elte.hu>
In-Reply-To: <20050210204031.GA17260@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing:
kernel/built-in.o(.text+0x4974): In function `copy_mm':
/usr/src/cvs/mvl-kernel-26/makena/linux-2.6.10/kernel/fork.c:493: undefined 
reference to `__spin_is_locked'
kernel/built-in.o(.text+0x9f5a): In function `next_thread':
/usr/src/cvs/mvl-kernel-26/makena/linux-2.6.10/kernel/exit.c:877: undefined 
reference to `__raw_rwlock_is_locked'
net/built-in.o(.text+0x1258): In function `__sock_create':
/usr/src/cvs/mvl-kernel-26/makena/linux-2.6.10/net/socket.c:175: undefined 
reference to `__spin_is_locked'
net/built-in.o(.text+0x16b54): In function `dev_deactivate':
/usr/src/cvs/mvl-kernel-26/makena/linux-2.6.10/net/sched/sch_generic.c:594: 
undefined reference to `__spin_is_locked'
make[1]: *** [vmlinux] Error 1
make: *** [bzImage] Error 2


Possibly from:
define __raw_spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
#define __raw_spin_unlock_wait(x) \
	do { barrier(); } while(__spin_is_locked(x))
in asm/spinlock.h

should that be __raw_spin_is_locked(x) instead?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


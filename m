Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSGIQbX>; Tue, 9 Jul 2002 12:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSGIQbW>; Tue, 9 Jul 2002 12:31:22 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:47840 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315388AbSGIQbU>; Tue, 9 Jul 2002 12:31:20 -0400
Date: Tue, 9 Jul 2002 10:34:00 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: rwh@memalpha.cx
Subject: WARNING in arch/i386/kernel/init_task.c
Message-ID: <Pine.LNX.4.44.0207091017540.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling 2.5 with the stack patch enabled, I get the following warning 
about the union thread_union init_thread_union:

/home/thunder/tmp/thunder-2.5/arch/i386/kernel/init_task.c:39: warning:
initialization from incompatible pointer type

union thread_union init_thread_union
        __attribute__((__section__(".data.init_task"))) =
               { {
                       task:           &init_task,
                       exec_domain:    &default_exec_domain,
                       flags:          0,
                       cpu:            0,
                       addr_limit:     KERNEL_DS,
                       irq_stack:      &init_irq_union,
               } };

Would it be OK to replace irq_stack: &init_irq_union with 
&init_irq_union.init_task?

.config used was configallmod

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------



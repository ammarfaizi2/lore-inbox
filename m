Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312213AbSCUO14>; Thu, 21 Mar 2002 09:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312233AbSCUO1p>; Thu, 21 Mar 2002 09:27:45 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:5008 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312213AbSCUO1a>; Thu, 21 Mar 2002 09:27:30 -0500
Date: Thu, 21 Mar 2002 09:44:58 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.7 doesn't link on Alpha.
Message-ID: <Pine.LNX.4.40.0203210937230.7618-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the patch I made yesterday to at least get everything compiling
for 2.5.7 on the Alpha, I'm still having trouble getting the final kernel
to link.  I've fixed two of the undefined references (one fix I'm not
happy with, but it works for me).  But these last 2 or 3 are giving me
more trouble.  I figure they are resulting from changes made recently, but
I don't see right away where it was done.  If someone could at least point
me in the right direction, that would be a big help.

Anyway, linking fails with:

init/main.o: In function `setup_per_cpu_areas':
init/main.o(.text.init+0x5e8): undefined reference to `__per_cpu_end'
init/main.o(.text.init+0x5f4): undefined reference to `__per_cpu_start'
arch/alpha/kernel/kernel.o: In function `handle_ipi':
arch/alpha/kernel/kernel.o(.text+0xc58c): undefined reference to `sched_task_migrated'
arch/alpha/kernel/kernel.o(.text+0xc590): undefined reference to `sched_task_migrated'
arch/alpha/kernel/kernel.o: In function `sys_call_table':
arch/alpha/kernel/kernel.o(.data+0xab0): undefined reference to `sys_nfsservctl'

I see there the sys_nfsservctl problem that seems to have plagued the last
few 2.5 releases.  I've looked at the patches that were applied, the
didn't seem to be i386 specific, so why is this still effecting the Alpha?

There is also those other two which I can't find anything about (well I
think it might be from the O(1) scheduler).

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks


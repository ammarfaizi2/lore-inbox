Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269877AbTGOXun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbTGOXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:50:43 -0400
Received: from aneto.able.es ([212.97.163.22]:34273 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S269877AbTGOXum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:50:42 -0400
Date: Wed, 16 Jul 2003 02:05:32 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: Re: gcc-3.3.1-hammer breaks mm/memory.c
Message-ID: <20030716000532.GC2447@werewolf.able.es>
References: <20030715222701.GC3823@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, J.A. Magallon wrote:
> Hi all...
> 
> After some binary search and a 'couple' kernel builds, I narrowed the
> problem to mm/memory.c. With that file built at -O1:
> 
> CFLAGS_memory.o = -O1
> 
> The kernel boots, starts /sbin/init and looks like working normally
> (2.4.22-pre5).
> 
> Anybody can see what is miscompiled with an assembler listing ?
> Any #pragma to switch optmizations on the half of a file or for
> a function ?
> 

I finally got this: -O2 fails but

CFLAGS_memory.o = -Os -falign-functions -falign-jumps -falign-loops -falign-labels -fprefetch-loop-arrays -freorder-blocks

works.

Those are specific options disabled by -Os, but -Os does more things...
(assembler output is very different)

Any SuSE site (hammer comes from SuSE, isn't it ?) to submit a decent
bug report ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre5-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.2mdk))

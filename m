Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143424AbRELAIJ>; Fri, 11 May 2001 20:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143425AbRELAH7>; Fri, 11 May 2001 20:07:59 -0400
Received: from jalon.able.es ([212.97.163.2]:40669 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S143424AbRELAHu>;
	Fri, 11 May 2001 20:07:50 -0400
Date: Sat, 12 May 2001 02:07:42 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
Message-ID: <20010512020742.A1054@werewolf.able.es>
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com>; from manfred@colorfullife.com on Fri, May 11, 2001 at 21:00:10 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.11 Manfred Spraul wrote:
> 
> Please test it.
> The kernel space part should be ok, but I know that the
> patch can cause deadlocks with buggy user space apps.
> 

I tried your patch on 2.4.4-ac8, and something strange happens.
Untarring linux-2.4.4 takes a little time, disk light flashes,
but no files appear on the disk (just 'Makefile', as you will see below).
Doing a separate gunzip - tar xf works fine:

werewolf:~/soft/kernel# gtar zxf linux-2.4.4.tar.gz
werewolf:~/soft/kernel# ls linux-2.4.4
Makefile
werewolf:~/soft/kernel# sync
werewolf:~/soft/kernel# ls linux-2.4.4
Makefile
werewolf:~/soft/kernel# gunzip linux-2.4.4.tar.gz
werewolf:~/soft/kernel# tar xf linux-2.4.4.tar
werewolf:~/soft/kernel# ls linux-2.4.4
COPYING         MAINTAINERS  REPORTING-BUGS  drivers/  init/    lib/  scripts/
CREDITS         Makefile     Rules.make      fs/       ipc/     mm/
Documentation/  README       arch/           include/  kernel/  net/


Some buffers get not flushed ???

If they can interact with yours, I have also applied the patches for
- cache-align from Andrea (I suppose it has nothing to do with yours)
- context-switches reduction by Mike Galbraith (perhaps ?)
and a silly couple more (CC:=$(CC) in Makefile, missing return in aic7xxx).

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac8 #1 SMP Sat May 12 01:16:37 CEST 2001 i686


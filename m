Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSADRjZ>; Fri, 4 Jan 2002 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288696AbSADRjQ>; Fri, 4 Jan 2002 12:39:16 -0500
Received: from mail.spylog.com ([194.67.35.220]:13776 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S279798AbSADRjC>;
	Fri, 4 Jan 2002 12:39:02 -0500
Date: Fri, 4 Jan 2002 20:38:51 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
Message-ID: <20020104173851.GA3027@spylog.ru>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201041743050.8766-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201041743050.8766-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo Molnar,


2.4.17 + A1 patch:

...
gcc -D__KERNEL__ -I/usr/src/linux-2.4.17-A1/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o syncookies.o syncookies.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.17-A1/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o ipconfig.o ipconfig.c
ipconfig.c: In function `ip_auto_config':
ipconfig.c:1148: `UNNAMED_MAJOR' undeclared (first use in this function)
ipconfig.c:1148: (Each undeclared identifier is reported only once
ipconfig.c:1148: for each function it appears in.)
make[3]: *** [ipconfig.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.17-A1/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.17-A1/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.17-A1/net'
make: *** [_dir_net] Error 2
suse:/usr/src/linux #


ps. vanilla kernel compile ok.


Once you wrote about "[patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.":
 
> this is the next release of the O(1) scheduler:
> 
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-A1.patch
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-A1.patch
> 
> this release includes fixes and small improvements. (The 2.5.2-A1 patch is
> against the 2.5.2-pre7 kernel.) I cannot reproduce any more failures with
> this patch, but i couldnt test the vfat lockup problem. The X lockup
> problem never occured on any of my boxes, but it might be fixed by one of
> the changes included in this patch nevertheless.
> 
> Changes:
> 
>  - idle process notification fixes. This fixes the idle=poll breakage
>    reported by Anton Blanchard.
> 
>  - fix a bug in setscheduler() which crashed if a non-SCHED_OTHER task did
>    a setscheduler() call. This fixes the crash reported by Randy Hron. The
>    Linux Test Project's syscall tests do not cause a crash anymore.
> 
>  - do some more unlikely()/likely() tagging of branches along the hotpath,
>    suggested by Jeff Garzik.
> 
>  - fix the compile failures in md.c and loop.c and other files, reported
>    by many people.
> 
>  - fix the too-big-by-one error in the bitmat sizing define, noticed by
>    Anton Blanchard.
> 
>  - fix a bug in rt_lock() + setscheduler() that had a potential for a
>    spinlock lockup.
> 
>  - introduce the idle_tick() function, so that idle CPUs can do
>    load-balancing as well.
> 
>  - do LINUX_VERSION_CODE checking in jffs2 (Jeff Garzik)
> 
>  - optimize the big-kernel-lock releasing/acquiring code some more. From
>    now on it's absolutely illegal to schedule() from cli()-ed code. (not
>    that it was legal.) This moves a few instructions off the scheduler
>    hotpath.
> 
>  - move the ->need_resched setting into idle_init().
> 
>  - do not clear RT tasks in reparent_to_init(). There's nothing bad with
>    running RT tasks in the background.
> 
>  - RT task's priority order was inverted, it should be 0-99, not 99-0.
> 
>  - make load-balancing a bit less eager when there are lots of processes
>    running: it needs a ~10% imbalance in runqueue lengths to trigger a
>    rebalance.
> 
>  - (there is a small hack in serial.c in the 2.5.2-pre7 patch, to make it
>    compile.)
> 
> Comments, bug reports, suggestions are welcome,
> 
> 	Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.

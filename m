Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWFGJSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWFGJSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWFGJSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:18:17 -0400
Received: from ms-smtp-02.tampabay.rr.com ([65.32.5.132]:52929 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932086AbWFGJSO (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Wed, 7 Jun 2006 05:18:14 -0400
Message-ID: <448699BD.1010702@cfl.rr.com>
Date: Wed, 07 Jun 2006 05:17:49 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kerneL@vger.kernel.org
CC: markh@compro.net, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: possible 2.6.16-rt23 OOM problem
References: <447611B6.9030807@compro.net>
In-Reply-To: <447611B6.9030807@compro.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:
> I'm seeing the following OOM on a number of machines. The machines are SMP P4s
> (non hyper threaded) with a GB of memory. I have intentionally turned off swap
> and clipped the memory to 512mb to cause this OOM to occur sooner. It takes
> hours otherwise. It only takes a few minutes this way.
> 
> /proc/meminfo before starting the task that is triggering this OOM
> 
> Thu May 25 14:43:32 EDT 2006
> 
> MemTotal:       496216 kB
> MemFree:         60756 kB
> Buffers:         20012 kB
> Cached:         288088 kB
> SwapCached:          0 kB
> Active:         141308 kB
> Inactive:       245444 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       496216 kB
> LowFree:         60756 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:             156 kB
> Writeback:           0 kB
> Mapped:         108248 kB
> Slab:            34960 kB
> CommitLimit:    248108 kB
> Committed_AS:   148160 kB
> PageTables:       1516 kB
> VmallocTotal:   770040 kB
> VmallocUsed:      8108 kB
> VmallocChunk:   761252 kB
> HugePages_Total:     0
> HugePages_Free:      0
> Hugepagesize:     4096 kB
> 
> 
> 
> oom-killer: gfp_mask=0x201d2, order=0
>  [<b0104239>] show_trace+0xd/0xf (8)
>  [<b0104252>] dump_stack+0x17/0x19 (12)
>  [<b01468eb>] out_of_memory+0x13a/0x15f (48)
>  [<b0148ae3>] __alloc_pages+0x257/0x2b9 (68)
>  [<b0149c9b>] __do_page_cache_readahead+0x1f2/0x27e (116)
>  [<b0149e2a>] do_page_cache_readahead+0x3d/0x51 (24)
>  [<b0144dbf>] filemap_nopage+0x141/0x3a0 (60)
>  [<b0150786>] __handle_mm_fault+0x128/0x8c4 (112)
>  [<b011379a>] do_page_fault+0x358/0x55e (76)
>  [<b010397b>] error_code+0x4f/0x54 (-465652988)
> DMA per-cpu:
> cpu 0 hot: high 0, batch 1 used:0
> cpu 0 cold: high 0, batch 1 used:0
> cpu 1 hot: high 0, batch 1 used:0
> cpu 1 cold: high 0, batch 1 used:0
> DMA32 per-cpu: empty
> Normal per-cpu:
> cpu 0 hot: high 186, batch 31 used:0
> cpu 0 cold: high 62, batch 15 used:0
> cpu 1 hot: high 186, batch 31 used:0
> cpu 1 cold: high 62, batch 15 used:0
> HighMem per-cpu: empty
> Free pages:        5256kB (0kB HighMem)
> Active:78861 inactive:3016 dirty:0 writeback:0 unstable:0 free:1314 slab:36397
> mapped:75422 pagetables:1231
> DMA free:2072kB min:88kB low:108kB high:132kB active:10564kB inactive:0kB
> present:16384kB pages_scanned:13500 all_unreclaimable? yes
> lowmem_reserve[]: 0 0 496 496
> DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
> pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 496 496
> Normal free:3184kB min:2804kB low:3504kB high:4204kB active:304880kB
> inactive:12064kB present:507904kB pages_scanned:37909 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> DMA: 2*4kB 0*8kB 1*16kB 0*32kB 2*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB
> 0*4096kB = 2072kB
> DMA32: empty
> Normal: 98*4kB 19*8kB 5*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 0*1024kB
> 1*2048kB 0*4096kB = 3184kB
> HighMem: empty
> Swap cache: add 0, delete 0, find 0/0, race 0+0
> Free swap  = 0kB
> Total swap = 0kB
> Out of Memory: Kill process 8041 (bash) score 83591 and children.
> Out of memory: Killed process 8154 (vrsx)
> 
> /proc/meminfo a second or so before vrsx is killed.
> 
> Thu May 25 14:48:55 EDT 2006
> 
> MemTotal:       496216 kB
> MemFree:          4892 kB
> Buffers:           340 kB
> Cached:          50880 kB
> SwapCached:          0 kB
> Active:         313284 kB
> Inactive:        15344 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       496216 kB
> LowFree:          4892 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:               0 kB
> Writeback:           0 kB
> Mapped:         302736 kB
> Slab:           144656 kB
> CommitLimit:    248108 kB
> Committed_AS:   499920 kB
> PageTables:       4952 kB
> VmallocTotal:   770040 kB
> VmallocUsed:      8188 kB
> VmallocChunk:   761252 kB
> HugePages_Total:     0
> HugePages_Free:      0
> Hugepagesize:     4096 kB
> 
> 
> 
> The offending task allocates a large SHM up front and uses mlockall with CURRENT
> | FUTURE flags. After that allocates no more memory. Not using mlockall doesn't
> change the outcome BTW.
> 
> This same task running on a vanilla 2.6.16.18 kernel does not OOM. I am fairly
> confident the application is not at fault.
> 
> Also, I have noticed that while in single user mode
> 
> watch -n1 cat /proc/meminfo
> 
> shows free memory slowly disappearing at ~100kb per minute. Over night 133mb
> disappeared. I believe this is related to the OOM above. I would imagine this
> symptom is easily reproducible as long as you have an SMP machine. Again doing
> the same thing while running a vanilla 2.6.16.18 kernel shows little to no
> fluctuation in memory.
> 
> I have also one UMP machine running the same kernel but do not see memory
> disappearing as on the SMP machines.
> 
> I'm running in complete preempt mode BTW.
> 
> Regards
> Mark
> 
> 
> 

Ok, I've narrowed this down some. I wish I could provide a fix but can't. I have
written a test case program that demonstrates the memory leak however. I also
have found something that makes the memory leak go away. The test case is below.
It will only run on an SMP machine. It basically pushes all tasks except for
already affinitized kernel threads off a CPU then binds its self to that CPU. It
then runs at FIFO pr 10 on that CPU. Memory slowly leaks away while it runs. If
run long enough your machine will die a slow death.

What I've found that eliminates the leak is changing the RT priority of the
[softirq-tasklet] that is also affinitized to my CPU. Changing it to be at least
one higher than the prio of my task (11), plugs the memory leak. I'm sure this
is significant.

I'm unclear as to the "rules of engagement" concerning already affinitized
kernel threads running FIFO in the rt kernel BTW. From a user standpoint I have
to assume that if the kernel affinitizes it, it was for a reason. If it is
running FIFO, it is for a reason.


This task will exit cleanly when receiving a SIGINT (^C)

#include <stdlib.h>
#include <errno.h>
#include <sched.h>
#include <unistd.h>
#include <stdio.h>
#include <linux/threads.h>
#include <limits.h>
#include <signal.h>

#ifndef PID_MAX
#define PID_MAX PID_MAX_DEFAULT
#endif
#define CONFIG_BASE_SMALL 0

char ok_to_affinitize(pid_t pid);
void schedule_cleanup();
void catcher(int sig);
int sched_setaffinity(pid_t pid, unsigned int len, unsigned long *mask);
int sched_getaffinity(pid_t pid, unsigned int len, unsigned long *mask);

char EXIT = 0;
int cpu_avail;
unsigned long tst_mask, affinity_mask;
pid_t pid;
struct sigaction sigblk;

int main()
{
    struct sched_param scheduling_param;
    unsigned int i;
    int no_of_cpus;
    unsigned int tst_size;

/*
 *  Get number of working CPUs on system.
 */
    no_of_cpus = sysconf(_SC_NPROCESSORS_ONLN);
    if (no_of_cpus < 2) {
        printf("Sorry this pgm requires more than 1 processor\n");
        exit(1);
    }

    tst_size = sizeof(tst_mask);

    cpu_avail = 0;
    for (i = 1; i <= no_of_cpus; i++)
        cpu_avail = (cpu_avail << 1) + 1;

    sigblk.sa_handler = catcher;
    sigblk.sa_flags = SA_RESTART;
    if (sigaction(SIGINT, &sigblk, 0) == -1) {
        printf("Unable to catch SIGINT\n");
        perror("Sigaction Error");
    }

/*
 *  Do affinity calls work?
 */
    if (sched_getaffinity(0, tst_size, &tst_mask) < 0) {
        printf("Affinity calls not funtioning.\n");
        perror("sched_getaffinity: ");
        exit(1);
    }

/*
 *  Set affinities
 */
    affinity_mask = (~2 & cpu_avail);
    for (pid = 0; pid < PID_MAX; pid++) {
        if (ok_to_affinitize(pid))
            sched_setaffinity(pid, sizeof(affinity_mask), &affinity_mask);
    }

    affinity_mask = 2;
    sched_setaffinity(0, sizeof(affinity_mask), &affinity_mask);

    scheduling_param.sched_priority = 10;
    if (sched_setscheduler(0, SCHED_FIFO, &scheduling_param) < 0) {
        perror("CPU sched_setscheduler");
        exit(1);
    }

    while (!EXIT); /* Slowly eat memory */

    sleep(5);     /* Memory comes back here */
    schedule_cleanup();
    exit(0);
}

void schedule_cleanup()
{
    affinity_mask = ~0;
    for (pid = 0; pid < PID_MAX; pid++) {
        if (ok_to_affinitize(pid))
            sched_setaffinity(pid, sizeof(affinity_mask), &affinity_mask);
    }
}

void catcher(int sig)
{
    if (sig == SIGINT)
        EXIT = 1;
}

/*
 *      Returns FALSE if task at pid is an already
 *      affinitized kernel thread or no task is
 *      associated with it at all.
 */

char ok_to_affinitize(pid_t pid)
{
    char buf[PATH_MAX];
    char *ret;
    char *cmdname;
    FILE *f;
    unsigned long tst_mask  = 0;
    unsigned int tst_size;

    tst_size = sizeof(tst_mask);

    snprintf(buf, PATH_MAX, "/proc/%d/cmdline", pid);
    f = fopen(buf, "r");
    if (f == NULL)
        return (0);

    cmdname = calloc(1,2);
    ret = fgets(cmdname, 2, f);
    fclose(f);
    free(cmdname);

    if (ret == NULL) {
        if (sched_getaffinity(pid, tst_size, &tst_mask) < 0) {
            return(0);
        } else {
            if (tst_mask != cpu_avail)
                return (0);
    }}
    return (1);
}

Regards
Mark

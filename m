Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSJYJNb>; Fri, 25 Oct 2002 05:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJYJNa>; Fri, 25 Oct 2002 05:13:30 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:48348 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261324AbSJYJN2>;
	Fri, 25 Oct 2002 05:13:28 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2002 11:19:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.44: Strange oopses triggered by pipe_write?
X-mailer: Pegasus Mail v3.50
Message-ID: <5991E8D4D49@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct 02 at 17:57, Petr Vandrovec wrote:

> Hi,
>   I just left my 2.5.44 box unattended for hour and half, and when
> I came back, I saw very strange things on screen:

Machine did it again yesterday 7:55 morning, after having ~10 hours
uptime. All three dumps are same, with minor difference in last one:
*pde is 024c4067, and Process line is 'cat (pid: 11497, threadinfo=c3960000,
task=d1c3a780)'... All other values are same.

And during boot I received:

...
Adding 1024120k swap on /dev/hda2.  Priority:-1 extents:1
EXT2-fs error (device ide0(3,1)): ext2_free_blocks: Freeing blocks not in
   datazone - block 3245558600, count = 38276
Checking root file system...
fsck 1.30-WIP (30-Sep-2002)
...   

It looks to me very strange that ext2 was freeing blocks while being
mounted read-only...

And I forgot in last mail: kernel is compiled WITHOUT preempt.
                                            Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

> Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
> Call Trace:
>   [<c011a0f3>] __might_sleep+0x43/0x47
>   [..........] pipe_write+0x7f/0x230
>   ...........  vfs_write+0xc1/0x160
>   ...........  sys_write+0x2a/0x3c
>   [<c0107437>] syscall_call+0x7/0xb
>  
> bad: scheduling while atomic!
>   [<c0117ea2>] schedule+0x2e/0x480
>   ............ sys_write+0x33/0x3c
>   [<c010745e>] work_resched+0x5/0x16
>
> Unable to handle kernel paging request at virtual address 401202b8
>  printing eip:
> 4004cb65
> *pde = 10f6a067
> *pte = 00000000
> Oops: 0004
> parport_pc parport tvaudio bttv tuner video-buf videodev i810_audio
>  ac97_codec soundcore af_packet nls_cp852 nls_iso8859-2 ipx p8022 psnap llc
>  e100
> CPU: 0
> EIP: 0023:[<4004cb65>]   Not tainted
> EFLAGS: 00010246
> eax: 00000004  ebx: 40131704  ecx: 4012d54c  edx: 401320a8
> esi: 00001000  edi: 00000000  ebp: bffffc88  esp: bffffc70
> ds: 002b  es: 002b  ss: 002b
> Process cat (pid: 26569, threadinfo=c586c000, task=da9ac100)
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> 
> It looks to me like that system first complained a bit about some
> spinlock being held, panicked in schedule, and then it printed
> very strange oopses: they look like userspace CPU context.
> 
> Kernel is 2.5.44, compiled for SMP, running on machine with 1 CPU.
> Before this incident machine was up for about 60 hours.
> After reboot fsck found 31 deleted inodes with zero dtime.
>                                                 Thanks,
>                                                     Petr Vandrovec
>                                                     vandrove@vc.cvut.cz

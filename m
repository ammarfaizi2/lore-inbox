Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbSKFWDJ>; Wed, 6 Nov 2002 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266159AbSKFWDJ>; Wed, 6 Nov 2002 17:03:09 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:21895 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266160AbSKFWDI>;
	Wed, 6 Nov 2002 17:03:08 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Nov 2002 23:09:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.44 (now 2.5.46-c929): Strange oopses triggered by ...
X-mailer: Pegasus Mail v3.50
Message-ID: <6C5F7CA168B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Oct 02 at 11:19, Petr Vandrovec wrote:
> On 23 Oct 02 at 17:57, Petr Vandrovec wrote:
> 
> > Hi,
> >   I just left my 2.5.44 box unattended for hour and half, and when
> > I came back, I saw very strange things on screen:
> 
> Machine did it again yesterday 7:55 morning, after having ~10 hours
> uptime. All three dumps are same, with minor difference in last one:
> *pde is 024c4067, and Process line is 'cat (pid: 11497, threadinfo=c3960000,
> task=d1c3a780)'... All other values are same.

I'm getting really nervous :-( Is kdb able to track who caused unbalanced
in_atomic() incrementation? 

After more than week of stable system I run simple 
"arp vanicka.vc.cvut.cz" few minutes ago, and after arp output I got 
sleeping function called from illegal context, quickly followed by two
scheduling while atomic, and finally it died because of userspace faults 
when in_atomic() is != 0 are treated as kernel ones...

As I saw nobody else reporting this or simillar problem, I'll start
looking at e100 driver I use. Maybe it did not occured because of I
was running -acX kernels since 25th Oct until yesterday. Anybody knows?
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
   [..........] __might_sleep+0x43/0x47
   [..........] seq_read
   ...........  vfs_read
   ...........  sys_read
   [..........] syscall_call+0x7/0xb
  
bad: scheduling while atomic!
   [..........] schedule
   ............ sys_read
   [..........] work_resched
   
bad: scheduling while atomic!
   [..........] schedule
   ............ sys_munmap
   [..........] work_resched

Unable to handle kernel paging request...

...
EIP: 0x4004DB65
...
Process: arp



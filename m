Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319125AbSIJOCI>; Tue, 10 Sep 2002 10:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319127AbSIJOCH>; Tue, 10 Sep 2002 10:02:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61606 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319125AbSIJOCF>;
	Tue, 10 Sep 2002 10:02:05 -0400
Date: Tue, 10 Sep 2002 16:06:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, andre@linux-ide.org
Subject: Re: 2.5.34 BUG at kernel/sched.c:944 (partitions code related?)
Message-ID: <20020910140622.GX8719@suse.de>
References: <20020910175639.A830@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020910175639.A830@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10 2002, Oleg Drokin wrote:
> Hello!
> 
>     Starting with yesterday I am seeing kernel BUG at sched.c:944 
>     on 2.5.3[34], I've seen similar report for 2.5.31 in the list with no
>     responces, however 2.5.31 was working fine for me.
> 
>     Stack trace for the BUG was entirely within idle task (default_idle,
>     rest_init, cpu_idle, ...)
> 
>     It explodes immediatelly after printing:
>  hda: hda1 hda2 hda3 hda4 < hda5
> 
>     Then panics trying to kill interrupt handler.
> 
>     On 2.4 this partition layout looks like this:
>  hda: [PTBL] [7476/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 >
> 
>    Box itself is Dual Athlon MP 1700+. IDE only, 1G RAM, highmem enabled.
> 
>    Other strange thing that caught my attention is this, if in 2.5.31 I had
>    this order or disk detection:
> <4>hda: IC35L060AVER07-0, ATA DISK drive
> <4>hdb: IC35L060AVER07-0, ATA DISK drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <4>hda: host protected area => 1
> <6>hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> <4>hdb: host protected area => 1
> <6>hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> <6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> <6> hdb: hdb1
> 
>    Now it does it in reverse like this:
> hdb: host protected area => 1
> hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> hdb: hdb1
> hda: host protected area => 1
> hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> hda: hda1 hda2 hda3 hda4 < hda5PANIC

Kernel compiled with preempt support or not?

-- 
Jens Axboe


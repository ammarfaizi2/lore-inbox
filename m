Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135916AbREBVEv>; Wed, 2 May 2001 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135940AbREBVEm>; Wed, 2 May 2001 17:04:42 -0400
Received: from mail.valinux.com ([198.186.202.175]:46603 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S135936AbREBVE3>;
	Wed, 2 May 2001 17:04:29 -0400
Date: Wed, 2 May 2001 15:03:11 -0600
From: Don Dugger <n0ano@valinux.com>
To: Zdenek Kabelac <kabi@i.am>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel doesn't create core for threads
Message-ID: <20010502150311.E1988@tlaloc.n0ano.com>
In-Reply-To: <3AF073AC.AE48BB78@i.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3AF073AC.AE48BB78@i.am>; from kabi@i.am on Wed, May 02, 2001 at 08:53:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zdenek-

Yes, this is a known problem.  I sent out a patch last month that
fixed this problem.  Unfortunately, the patch caused some kernel
hangs that I just fixed today.  I'm testing the fix now so expect
a new patch either this afternoon or tomorrow that will fix this.

On Wed, May 02, 2001 at 08:53:00PM +0000, Zdenek Kabelac wrote:
> Hello
> 
> Looks to me like the latest 2.4.5-pre1 is not creating
> coredump for multithreaded aplications:
> 
> ----
> $ ulimit  -a
> core file size (blocks)     unlimited
> data seg size (kbytes)      unlimited
> file size (blocks)          unlimited
> max locked memory (kbytes)  unlimited
> max memory size (kbytes)    unlimited
> open files                  1024
> pipe size (512 bytes)       8
> stack size (kbytes)         8192
> cpu time (seconds)          unlimited
> max user processes          6144
> virtual memory (kbytes)     unlimited
> 
> $ ./testcore 
> Segmentation fault
> 
> 
> --- test program --
> 
> #include <stdio.h>
> #include <pthread.h>
> 
> #define TASKS 10
> 
> void* thread(void* arg)
> {
>     printf("yuk %s\n", 0xffff0000);
>     return 0;
> }
> 
> int main(int argc, char *argv[])
> {
>     pthread_t task[TASKS];
>     void* ret;
>     int i = 0;
>     for(i = 0; i < TASKS; i++)
> 	pthread_create(&task[i], NULL, thread, 0);
>     for(i = 0; i < TASKS; i++)
> 	pthread_join(task[i], &ret);
> 
>     return 0;
> }
> ---
> 
> 
> for single threadad apps there is no problem:
> (just put printf after int i declaration)
> $ ./testcore 
> Segmentation fault (core dumped)
> 
> ---
> 
> Am I doing something wrong ???
> 
> Also for quite a long time Alan's AC patches were efictively locking
> my machine when threaded application was crashing - resolvin
> almost original behaviour solved this problem - but I like 
> per-thread coredump - is there any special reason why this is still
> not present in the current 2.4.4 kernel as I can see this as quite
> usefull.
> 
> 
> bye
> 
> 
> kabi@i.am
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838

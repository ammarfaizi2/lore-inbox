Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318398AbSGYKd0>; Thu, 25 Jul 2002 06:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318402AbSGYKd0>; Thu, 25 Jul 2002 06:33:26 -0400
Received: from spirit.qbfox.com ([212.67.200.51]:5649 "EHLO spirit.qbfox.com")
	by vger.kernel.org with ESMTP id <S318398AbSGYKdY>;
	Thu, 25 Jul 2002 06:33:24 -0400
Message-Id: <200207251036.LAA04618@spirit.qbfox.com>
From: Per Gregers Bilse <bilse@qbfox.com>
Date: Thu, 25 Jul 2002 11:36:36 +0100
In-Reply-To: <200207251001.LAA04512@spirit.qbfox.com>
Organization: qbfox
X-Mailer: Mail User's Shell (7.2.2 4/12/91)
To: george anzinger <george@mvista.com>
Subject: Re: 2.4.18 clock warps 4294 seconds
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, 11:01am, Per Gregers Bilse <bilse@qbfox.com> wrote:
> Ie, set flag/value in do_fast_gettimeoffset(), check/print in
> do_gettimeofday().  I figure that should catch it if it happens
> again, and safely so.

Not sure if that's the right thing to do, the check succeeds very
frequently.  A modified version, printing only every 1000th time,
yields:

Jul 25 11:18:36 vulpes kernel: do_gettimeofday warp 0 eax 6968466
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 1000 eax 5301486
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 2000 eax 5814470
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 3000 eax 6238995
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 4000 eax 6662828
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 5000 eax 7109559
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 6000 eax 7534440
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 7000 eax 7959034
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 8000 eax 6302366
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 9000 eax 6736399
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 10000 eax 7160461
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 11000 eax 7584511
Jul 25 11:18:39 vulpes kernel: do_gettimeofday warp 12000 eax 5855713
Jul 25 11:19:15 vulpes kernel: do_gettimeofday warp 13000 eax 6265463
Jul 25 11:19:15 vulpes kernel: do_gettimeofday warp 14000 eax 7992560
Jul 25 11:19:15 vulpes kernel: do_gettimeofday warp 15000 eax 6263791
Jul 25 11:19:20 vulpes kernel: do_gettimeofday warp 16000 eax 5247486
Jul 25 11:19:20 vulpes kernel: do_gettimeofday warp 17000 eax 6358315
Jul 25 11:19:20 vulpes kernel: do_gettimeofday warp 18000 eax 7393344
Jul 25 11:19:20 vulpes kernel: do_gettimeofday warp 19000 eax 6237626
Jul 25 11:19:20 vulpes kernel: do_gettimeofday warp 20000 eax 6406708
Jul 25 11:19:21 vulpes kernel: do_gettimeofday warp 21000 eax 6005906
Jul 25 11:19:21 vulpes kernel: do_gettimeofday warp 22000 eax 5056750
Jul 25 11:19:23 vulpes kernel: do_gettimeofday warp 23000 eax 6434750
Jul 25 11:19:24 vulpes kernel: do_gettimeofday warp 24000 eax 5093940
Jul 25 11:19:25 vulpes kernel: do_gettimeofday warp 25000 eax 6269335
Jul 25 11:19:26 vulpes kernel: do_gettimeofday warp 26000 eax 5596617
Jul 25 11:19:27 vulpes kernel: do_gettimeofday warp 27000 eax 7918244
Jul 25 11:19:29 vulpes kernel: do_gettimeofday warp 28000 eax 7266647
Jul 25 11:19:33 vulpes kernel: do_gettimeofday warp 29000 eax 5293260
Jul 25 11:19:53 vulpes kernel: do_gettimeofday warp 30000 eax 6751016
Jul 25 11:21:32 vulpes kernel: do_gettimeofday warp 31000 eax 6213632
Jul 25 11:23:24 vulpes kernel: do_gettimeofday warp 32000 eax 6997568
Jul 25 11:24:16 vulpes kernel: do_gettimeofday warp 33000 eax 5326413
Jul 25 11:25:10 vulpes kernel: do_gettimeofday warp 34000 eax 5717715
Jul 25 11:25:37 vulpes kernel: do_gettimeofday warp 35000 eax 6464694
Jul 25 11:26:19 vulpes kernel: do_gettimeofday warp 36000 eax 5969042
Jul 25 11:27:05 vulpes kernel: do_gettimeofday warp 37000 eax 7196006
Jul 25 11:28:10 vulpes kernel: do_gettimeofday warp 38000 eax 7129216
Jul 25 11:28:40 vulpes kernel: do_gettimeofday warp 39000 eax 5971848
Jul 25 11:29:04 vulpes kernel: do_gettimeofday warp 40000 eax 6347832
Jul 25 11:29:38 vulpes kernel: do_gettimeofday warp 41000 eax 6769141
Jul 25 11:30:19 vulpes kernel: do_gettimeofday warp 42000 eax 5279110
Jul 25 11:31:18 vulpes kernel: do_gettimeofday warp 43000 eax 6256288
Jul 25 11:31:34 vulpes kernel: do_gettimeofday warp 44000 eax 6483175

Here are complete code excerpts from arch/i386/kernel/time.c,
look for glob_eax:

static unsigned long glob_eax;

static inline unsigned long do_fast_gettimeoffset(void)
{
        register unsigned long eax, edx;

        /* Read the Time Stamp Counter */

        rdtsc(eax,edx);

        /* .. relative to previous jiffy (32 bits is enough) */
        eax -= last_tsc_low;    /* tsc_low delta */

        if ( eax > 5000000 ) {
                glob_eax = eax;
                return delay_at_last_interrupt;
        }


        /*
         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
         *             = (tsc_low delta) * (usecs_per_clock)
         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
         *
         * Using a mull instead of a divl saves up to 31 clock cycles
         * in the critical path.
         */

        __asm__("mull %2"
                :"=a" (eax), "=d" (edx)
                :"rm" (fast_gettimeoffset_quotient),
                 "0" (eax));

        /* our adjusted time offset in microseconds */
        return delay_at_last_interrupt + edx;
}


void do_gettimeofday(struct timeval *tv)
{
        unsigned long flags;
        unsigned long usec, sec;
        static unsigned warp;

        read_lock_irqsave(&xtime_lock, flags);
        usec = do_gettimeoffset();
        {
                unsigned long lost = jiffies - wall_jiffies;
                if (lost)
                        usec += lost * (1000000 / HZ);
        }
        sec = xtime.tv_sec;
        usec += xtime.tv_usec;
        read_unlock_irqrestore(&xtime_lock, flags);

        while (usec >= 1000000) {
                usec -= 1000000;
                sec++;
        }

        tv->tv_sec = sec;
        tv->tv_usec = usec;

        if ( glob_eax != 0 ) {
                if ( warp % 1000 == 0 )
                        printk("do_gettimeofday warp %u eax %lu\n",warp,glob_eax);
                warp++;
                glob_eax = 0;
        }
}

Is this correctly detecting the problem?  Or is the low word (eax) of the TSC
a red herring?

Thanks.

  -- Per


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266245AbRGJMS3>; Tue, 10 Jul 2001 08:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbRGJMSU>; Tue, 10 Jul 2001 08:18:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39895 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266245AbRGJMSM>;
	Tue, 10 Jul 2001 08:18:12 -0400
Message-ID: <3B4AF282.A5EA4FA2@mandrakesoft.com>
Date: Tue, 10 Jul 2001 08:18:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-pre5 missing symbols?
In-Reply-To: <20010710115400.5ED711C495@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> Is it just me or is there something missing?
> 
> oscar# depmod -ae 2.4.7-pre5
> depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/8139too.o
> depmod:         cpu_raise_softirq
> depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/ppp_generic.o
> depmod:         cpu_raise_softirq
> depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/tulip/tulip.o
> depmod:         cpu_raise_softirq
> depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/via-rhine.o
> depmod:         cpu_raise_softirq

Look like a bad patch, pre5 definitely has the following:

> diff -Naur -X /g/g/lib/dontdiff linux-2.4.7-pre4/kernel/ksyms.c linux-2.4.7-pre5/k
> ernel/ksyms.c
> --- linux-2.4.7-pre4/kernel/ksyms.c     Mon Jul  9 23:11:59 2001
> +++ linux-2.4.7-pre5/kernel/ksyms.c     Tue Jul 10 02:00:58 2001
> @@ -538,6 +538,8 @@
>  EXPORT_SYMBOL(tasklet_kill);
>  EXPORT_SYMBOL(__run_task_queue);
>  EXPORT_SYMBOL(do_softirq);
> +EXPORT_SYMBOL(raise_softirq);
> +EXPORT_SYMBOL(cpu_raise_softirq);
>  EXPORT_SYMBOL(tasklet_schedule);
>  EXPORT_SYMBOL(tasklet_hi_schedule);
>  

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |

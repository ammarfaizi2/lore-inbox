Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbTCWQ76>; Sun, 23 Mar 2003 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbTCWQ76>; Sun, 23 Mar 2003 11:59:58 -0500
Received: from smtpout.mac.com ([17.250.248.88]:47315 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S263117AbTCWQ75>;
	Sun, 23 Mar 2003 11:59:57 -0500
Subject: Re: [2.5 patch] fix sound/oss/ics2101.c compilation
From: Peter Waechtler <pwaechtler@mac.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030321201012.GO6940@fs.tum.de>
References: <20030321201012.GO6940@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Mar 2003 19:11:03 +0100
Message-Id: <1048443066.1936.2.camel@picklock>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2003-03-21 um 21.10 schrieb Adrian Bunk:
> The following patch fixes the problem for me, please check whether it's 
> correct:
> 
> --- linux-2.5.65-full/sound/oss/ics2101.c.old	2003-03-21 19:13:23.000000000 +0100
> +++ linux-2.5.65-full/sound/oss/ics2101.c	2003-03-21 19:13:53.000000000 +0100
> @@ -29,7 +29,7 @@
>  
>  extern int     *gus_osp;
>  extern int      gus_base;
> -extern spinlock_t lock;
> +spinlock_t      lock = SPIN_LOCK_UNLOCKED;
>  static int      volumes[ICS_MIXDEVS];
>  static int      left_fix[ICS_MIXDEVS] =
>  {1, 1, 1, 2, 1, 2};
> 

With that patch you do not protect anything.
The write_mix function should share the spinlock used in the 
interrupt handler.

Do you compile for Uniprocessor? Can you post the relevant config?
I don't get a link error with SMP.



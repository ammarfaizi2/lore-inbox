Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265859AbSKFRkO>; Wed, 6 Nov 2002 12:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSKFRkN>; Wed, 6 Nov 2002 12:40:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14582 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265859AbSKFRkM>;
	Wed, 6 Nov 2002 12:40:12 -0500
Message-ID: <3DC95565.35F01941@mvista.com>
Date: Wed, 06 Nov 2002 09:46:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Skip Ford <skip.ford@verizon.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 13
References: <3DC8B75F.4B425973@mvista.com> <200211060827.gA68RoKb021008@pool-141-150-241-241.delv.east.verizon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:
> 
> george anzinger wrote:
> >
> > -     tvec_base_t *old_base, *new_base;
> > +     tvec_base_t *new_base;
> > +     IF_SMP( tvec_base_t *old_base;)
> 
> Your code doesn't compile.  old_base only exists ifdef CONFIG_SMP but
> it's referneced for UP compiles @ timer.c:line 332
> 
>         if (old_base) {
>                 list_del(&timer->entry);
>                 ret = 1;
>         }
> 
> ifdeffing it out works but I don't know if it's correct.  That's one
> ugly function with your patch applied so one more ifdef won't hurt
> (unless it's wrong.)

Thanks, I will check it out and resubmit.

-g
> 
> --- linux-sk/kernel/timer.c~fix-high-res        Wed Nov  6 03:14:30 2002
> +++ linux-sk-jr/kernel/timer.c  Wed Nov  6 03:14:30 2002
> @@ -329,10 +329,12 @@ repeat:
>          * Delete the previous timeout (if there was any), and install
>          * the new one:
>          */
> +#ifdef CONFIG_SMP
>         if (old_base) {
>                 list_del(&timer->entry);
>                 ret = 1;
>         }
> +#endif
>         timer->expires = expires;
>         IF_HIGH_RES(timer->sub_expires = sub_expires);
>         internal_add_timer(new_base, timer);
> 
> --
> Skip
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSLTKeO>; Fri, 20 Dec 2002 05:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSLTKeO>; Fri, 20 Dec 2002 05:34:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40956 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261368AbSLTKeL>;
	Fri, 20 Dec 2002 05:34:11 -0500
Message-ID: <3E02F3EE.C1367073@mvista.com>
Date: Fri, 20 Dec 2002 02:41:50 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] joydev: fix HZ->millisecond transformation
References: <200212161227.38764.bjorn_helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> 
> * fix a problem with HZ->millisecond transformation on
>   non-x86 archs (from 2.5 change by vojtech@suse.cz)
> 
> Applies to 2.4.20.
> 
> diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
> --- a/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> +++ b/drivers/input/joydev.c    Mon Dec 16 12:16:32 2002
> @@ -50,6 +50,8 @@
>  #define JOYDEV_MINORS          32
>  #define JOYDEV_BUFFER_SIZE     64
> 
> +#define MSECS(t)       (1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
Uh...                                                
^^^^^^^^^^^^^^^^
by definition this is zero, is it not?

> +
>  struct joydev {
>         int exist;
>         int open;
> @@ -134,7 +136,7 @@
>                         return;
>         }
> 
> -       event.time = jiffies * (1000 / HZ);
> +       event.time = MSECS(jiffies);
> 
>         while (list) {
> 
> @@ -279,7 +281,7 @@
> 
>                 struct js_event event;
> 
> -               event.time = jiffies * (1000/HZ);
> +               event.time = MSECS(jiffies);
> 
>                 if (list->startup < joydev->nkey) {
>                         event.type = JS_EVENT_BUTTON | JS_EVENT_INIT;
> 
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

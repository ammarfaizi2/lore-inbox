Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbTKFX0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTKFX0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:26:53 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:64922 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263864AbTKFX0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:26:40 -0500
Message-ID: <3FAAD8AA.8060303@nortelnetworks.com>
Date: Thu, 06 Nov 2003 18:26:34 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: mgross@linux.co.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP signal latency fix up.
References: <1068158989.3555.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross wrote:

> diff -urN -X dontdiff linux-2.6.0-test9/kernel/sched.c /opt/linux-2.6.0-test9/kernel/sched.c
> --- linux-2.6.0-test9/kernel/sched.c    2003-10-25 11:44:29.000000000 -0700
> +++ /opt/linux-2.6.0-test9/kernel/sched.c       2003-11-06 13:04:03.628116240 -0800
> @@ -626,13 +626,13 @@
>                         }
>                         success = 1;
>                 }
> -#ifdef CONFIG_SMP
> -               else
> -                       if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> -                               smp_send_reschedule(task_cpu(p));
> -#endif
>                 p->state = TASK_RUNNING;
>         }
> +#ifdef CONFIG_SMP
> +               else
> +               if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> +                       smp_send_reschedule(task_cpu(p));
> +#endif
>         task_rq_unlock(rq, &flags);

Without any comment as to whether or not the patch would work, shouldn't 
the "else" be moved back by a tab?

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


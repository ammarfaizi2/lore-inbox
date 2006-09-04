Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWIDQx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWIDQx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWIDQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:53:56 -0400
Received: from mail.tmr.com ([64.65.253.246]:10645 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S964811AbWIDQxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:53:55 -0400
Message-ID: <44FC5B68.7080500@tmr.com>
Date: Mon, 04 Sep 2006 12:59:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: adam radford <aradford@gmail.com>
CC: Jim Klimov <klimov@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: 3ware glitches cause softraid rebuilds
References: <1926236045.20060829034652@2ka.mipt.ru> <b1bc6a000608281756s1e76a80eq5f70e654e2e7e3e3@mail.gmail.com>
In-Reply-To: <b1bc6a000608281756s1e76a80eq5f70e654e2e7e3e3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam radford wrote:

> Jim,
>
> Can you try the attached (and below) patch for 2.6.17.11?


Don't you want the sleep BEFORE setting the new value? ie. giving a wait 
for status to change before checking it again?

>
> Also, please make sure you are running the latest firmware.
>
> Thanks,
>
> -Adam
>
> diff -Naur linux-2.6.17.11/drivers/scsi/3w-9xxx.c
> linux-2.6.17.12/drivers/scsi/3w-9xxx.c
> --- linux-2.6.17.11/drivers/scsi/3w-9xxx.c    2006-08-23 
> 14:16:33.000000000 -0700
> +++ linux-2.6.17.12/drivers/scsi/3w-9xxx.c    2006-08-28 
> 17:48:29.000000000 -0700
> @@ -943,6 +943,7 @@
>         before = jiffies;
>         while ((response_que_value & TW_9550SX_DRAIN_COMPLETED) !=
> TW_9550SX_DRAIN_COMPLETED) {
>             response_que_value = 
> readl(TW_RESPONSE_QUEUE_REG_ADDR_LARGE(tw_dev));
> +            msleep(1);
>             if (time_after(jiffies, before + HZ * 30))
>                 goto out;
>         }
>
>------------------------------------------------------------------------
>
>diff -Naur linux-2.6.17.11/drivers/scsi/3w-9xxx.c linux-2.6.17.12/drivers/scsi/3w-9xxx.c
>--- linux-2.6.17.11/drivers/scsi/3w-9xxx.c	2006-08-23 14:16:33.000000000 -0700
>+++ linux-2.6.17.12/drivers/scsi/3w-9xxx.c	2006-08-28 17:48:29.000000000 -0700
>@@ -943,6 +943,7 @@
> 		before = jiffies;
> 		while ((response_que_value & TW_9550SX_DRAIN_COMPLETED) != TW_9550SX_DRAIN_COMPLETED) {
> 			response_que_value = readl(TW_RESPONSE_QUEUE_REG_ADDR_LARGE(tw_dev));
>+			msleep(1);
> 			if (time_after(jiffies, before + HZ * 30))
> 				goto out;
> 		}
>  
>


-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


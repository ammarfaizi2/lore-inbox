Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVCGINr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVCGINr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVCGINr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:13:47 -0500
Received: from miranda.se.axis.com ([193.13.178.2]:40932 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261678AbVCGINn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:13:43 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <domen@coderock.org>
Cc: <linux-kernel@vger.kernel.org>, <domen@coderock.org>, <nacc@us.ibm.com>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Subject: RE: [patch 10/14] serial/crisv10: replace schedule_timeout() with msleep()
Date: Mon, 7 Mar 2005 09:13:26 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C77D7@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668026F8BAA@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that is correct. Please apply.

Acked-by: Mikael Starvik <starvik@axis.com>

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
Sent: Monday, March 07, 2005 4:36 AM
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org; domen@coderock.org; nacc@us.ibm.com;
Mikael Starvik
Subject: Re: [patch 10/14] serial/crisv10: replace schedule_timeout() with
msleep()


domen@coderock.org wrote:
>
> Use msleep() instead of schedule_timeout() to guarantee the task
>  delays as expected. The current code uses TASK_INTERRUPTIBLE, but does
not care
>  about signals, so I believe msleep() should be ok.
> 
>  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>  Signed-off-by: Domen Puncer <domen@coderock.org>
>  ---
> 
> 
>   kj-domen/drivers/serial/crisv10.c |    6 ++----
>   1 files changed, 2 insertions(+), 4 deletions(-)
> 
>  diff -puN drivers/serial/crisv10.c~msleep-drivers_serial_crisv10
drivers/serial/crisv10.c
>  --- kj/drivers/serial/crisv10.c~msleep-drivers_serial_crisv10
2005-03-05 16:10:52.000000000 +0100
>  +++ kj-domen/drivers/serial/crisv10.c	2005-03-05
16:10:52.000000000 +0100
>  @@ -3757,10 +3757,8 @@ rs_write(struct tty_struct * tty, int fr
>   		e100_enable_rx_irq(info);
>   #endif
>   
>  -		if (info->rs485.delay_rts_before_send > 0) {
>  -			set_current_state(TASK_INTERRUPTIBLE);
>  -			schedule_timeout((info->rs485.delay_rts_before_send
* HZ)/1000);
>  -		}
>  +		if (info->rs485.delay_rts_before_send > 0)
>  +			msleep(info->rs485.delay_rts_before_send);

Behavioural change: we'll no longer break out of the sleep if a signal is
pending.  Which probably means you fixed a bug ;)

Please work it with Mikael.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


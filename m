Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVCSTgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVCSTgC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVCSTgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:36:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261738AbVCSTfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:35:53 -0500
Date: Sat, 19 Mar 2005 19:35:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: domen@coderock.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 01/10] char/ds1620: use msleep() instead of schedule_timeout()
Message-ID: <20050319193548.F23907@flint.arm.linux.org.uk>
Mail-Followup-To: domen@coderock.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <20050319131716.DB08C1ECA8@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050319131716.DB08C1ECA8@trashy.coderock.org>; from domen@coderock.org on Sat, Mar 19, 2005 at 02:17:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 02:17:15PM +0100, domen@coderock.org wrote:
> Not sure why any driver needs to sleep for *two* ticks, so let's fix it.
> 
> Use msleep() instead of schedule_timeout() to guarantee the
> task delays as expected. Signals are never checked for by the callers or
> in the function itself, so use TASK_UNINTERRUPTIBLE instead of
> TASK_INTERRUPTIBLE. The delay is presumed to have been written when HZ==100,
> and thus has been multiplied by 10 to pass to msleep().
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Acked-by: Russell King <rmk@arm.linux.org.uk>

> ---
> 
> 
>  kj-domen/drivers/char/ds1620.c |    3 +--
>  1 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN drivers/char/ds1620.c~msleep-drivers_char_ds1620 drivers/char/ds1620.c
> --- kj/drivers/char/ds1620.c~msleep-drivers_char_ds1620	2005-03-18 20:05:09.000000000 +0100
> +++ kj-domen/drivers/char/ds1620.c	2005-03-18 20:05:09.000000000 +0100
> @@ -163,8 +163,7 @@ static void ds1620_out(int cmd, int bits
>  	netwinder_ds1620_reset();
>  	netwinder_unlock(&flags);
>  
> -	set_current_state(TASK_INTERRUPTIBLE);
> -	schedule_timeout(2);
> +	msleep(20);
>  }
>  
>  static unsigned int ds1620_in(int cmd, int bits)
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

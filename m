Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVCNRv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVCNRv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVCNRv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:51:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29367 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261642AbVCNRqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:46:18 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: domen@coderock.org, ghoward@sgi.com
Subject: Re: [patch 01/14] char/snsc: reorder set_current_state() and add_wait_queue()
Date: Mon, 14 Mar 2005 09:45:44 -0800
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <20050306223616.C82751EC90@trashy.coderock.org>
In-Reply-To: <20050306223616.C82751EC90@trashy.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140945.44323.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 6, 2005 2:36 pm, domen@coderock.org wrote:
> Any comments would be, as always, appreciated.

I don't have a problem with this change, but the maintainer probably should 
have been Cc'd.  Greg, does this change look ok to you?  Note that it's 
already been committed to the upstream tree, so if it's a bad change we'll 
need to have the cset excluded or something.

>
> -Nish
>
> Reorder add_wait_queue() and set_current_state() as a
> signal could be lost in between the two functions.
>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
>
>
>  kj-domen/drivers/char/snsc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff -puN drivers/char/snsc.c~reorder-state-drivers_char_snsc
> drivers/char/snsc.c ---
> kj/drivers/char/snsc.c~reorder-state-drivers_char_snsc 2005-03-05
> 16:09:54.000000000 +0100 +++ kj-domen/drivers/char/snsc.c 2005-03-05
> 16:09:54.000000000 +0100 @@ -192,8 +192,8 @@ scdrv_read(struct file *file,
> char __use
>    }
>
>    len = CHUNKSIZE;
> -  add_wait_queue(&sd->sd_rq, &wait);
>    set_current_state(TASK_INTERRUPTIBLE);
> +  add_wait_queue(&sd->sd_rq, &wait);
>    spin_unlock_irqrestore(&sd->sd_rlock, flags);
>
>    schedule_timeout(SCDRV_TIMEOUT);
> @@ -288,8 +288,8 @@ scdrv_write(struct file *file, const cha
>     return -EAGAIN;
>    }
>
> -  add_wait_queue(&sd->sd_wq, &wait);
>    set_current_state(TASK_INTERRUPTIBLE);
> +  add_wait_queue(&sd->sd_wq, &wait);
>    spin_unlock_irqrestore(&sd->sd_wlock, flags);
>
>    schedule_timeout(SCDRV_TIMEOUT);
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUGBOkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUGBOkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUGBOkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:40:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51912 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262605AbUGBOko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:40:44 -0400
Message-ID: <40E573DE.6090303@pobox.com>
Date: Fri, 02 Jul 2004 10:40:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] meye driver update (wait_ms -> msleep)
References: <20040702140825.GD2942@crusoe.alcove-fr>
In-Reply-To: <20040702140825.GD2942@crusoe.alcove-fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> ===== drivers/media/video/meye.c 1.21 vs edited =====
> --- 1.21/drivers/media/video/meye.c	2004-03-19 07:04:56 +01:00
> +++ edited/drivers/media/video/meye.c	2004-07-02 10:58:36 +02:00
> @@ -473,16 +473,6 @@
>  /* MCHIP low-level functions                                                */
>  /****************************************************************************/
>  
> -/* waits for the specified miliseconds */
> -static inline void wait_ms(unsigned int ms) {
> -	if (!in_interrupt()) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(1 + ms * HZ / 1000);
> -	}
> -	else
> -		mdelay(ms);
> -}
> -

I was worried about in_interrupt() removal (when you unconditionally use 
msleep), so I reviewed this in-depth.  Looks OK to me.

ACK

	Jeff



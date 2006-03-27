Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWC0RD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWC0RD6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWC0RD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:03:58 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:41480 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751115AbWC0RD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:03:58 -0500
Date: Mon, 27 Mar 2006 19:03:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-mm1 1/3] rtc: m41t00 driver should use workqueue
 instead of tasklet
Message-Id: <20060327190358.742eafb3.khali@linux-fr.org>
In-Reply-To: <20060324011846.GC9560@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324011846.GC9560@mag.az.mvista.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> The m41t00 i2c/rtc driver currently uses a tasklet to schedule interrupt-level
> writes to the rtc.  This patch causes the driver to use a workqueue instead.
> (...)
>  int
>  m41t00_set_rtc_time(ulong nowtime)
>  {
>  	new_time = nowtime;
>  
>  	if (in_interrupt())
> -		tasklet_schedule(&m41t00_tasklet);
> +		schedule_work(&set_rtc_time_task);
>  	else
> -		m41t00_set_tlet((ulong)&new_time);
> +		m41t00_set((void *)&new_time);

This cast is not needed.

>  
>  	return 0;
>  }

Thanks,
-- 
Jean Delvare

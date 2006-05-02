Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWEBURA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWEBURA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWEBURA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:17:00 -0400
Received: from mx0.towertech.it ([213.215.222.73]:9878 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932134AbWEBUQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:16:59 -0400
Date: Tue, 2 May 2006 22:15:35 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@osdl.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: rtc-dev UIE emulation
Message-ID: <20060502221535.01692c24@inspiron>
In-Reply-To: <20060501.233242.59466338.anemo@mba.ocn.ne.jp>
References: <20060429.011648.25910123.anemo@mba.ocn.ne.jp>
	<20060428232306.5049c30d.akpm@osdl.org>
	<20060430.001003.52129547.anemo@mba.ocn.ne.jp>
	<20060501.233242.59466338.anemo@mba.ocn.ne.jp>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2006 23:32:42 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> Here is an updated patch.  I think this one reflects all suggestions
> by Andrew.

 seems ok to me, just a few comments:


> +	  driver did not provides RTC_UIE ioctls.  RTC_UIE is required
> +	  by some programs, such as hwclock.

 please fix the double spacing and s/provides/provide/ 

 hwclock will be fixed to not rely on uie anymore anyway.


> +#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
> +	INIT_WORK(&rtc->uie_task, rtc_uie_task, rtc);
> +	setup_timer(&rtc->uie_timer, rtc_uie_timer, (unsigned long)rtc);
> +	rtc->irq_active = 0;
> +	rtc->stop_uie_polling = 0;
> +	rtc->uie_task_active = 0;
> +	rtc->uie_timer_active = 0;
> +#endif

 the rtc struct is allocated via kzalloc, so 
 you don't need to zero it.



-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


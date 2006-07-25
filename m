Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWGYRzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWGYRzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWGYRzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:55:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51168 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750828AbWGYRzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:55:42 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725174100.GA4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 19:55:39 +0200
Message-Id: <1153850139.8932.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -265,6 +269,7 @@ irqreturn_t rtc_interrupt(int irq, void 
>  
>  	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
>  
> +	*count_ptr = (*count_ptr)++;

Hi,

it's a cute idea, however 3 questions:
1) you probably want to add a few memory barriers around this, right?
2) why use the rtc and not the regular timer interrupt?

(and 
3) this will negate the power gain you get for tickless kernels, since
now they need to start ticking again ;( )

Greetings,
   Arjan van de Ven


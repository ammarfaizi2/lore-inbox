Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVLZXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVLZXpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVLZXpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:45:39 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:26553 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932162AbVLZXpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:45:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [RFC][PATCH 7/7] RTC subsystem, test device/driver
Date: Mon, 26 Dec 2005 18:45:34 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20051226195913.6f680634@inspiron>
In-Reply-To: <20051226195913.6f680634@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512261845.34731.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 December 2005 13:59, Alessandro Zummo wrote:
> +struct platform_device test_dev_zero = {
> +	.name	= "rtc-test",
> +	.id	= 0,
> +	.dev.release = test_release,
> +};
> +
> +struct platform_device test_dev_one = {
> +	.name	= "rtc-test",
> +	.id	= 1,
> +	.dev.release = test_release,
> +};
> +

You should never ever statically allicate devices that can be unregistered.
Guess what will happen if one does this:

	rmmod rtc_test  < /sys/class/rtc/rtcX/date

where rctX is class device created by rtc-test0 or rtc-test1.

-- 
Dmitry

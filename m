Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVLUCBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVLUCBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVLUCBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:01:43 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:61048 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932235AbVLUCBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:01:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Date: Tue, 20 Dec 2005 21:01:39 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051220214511.12bbb69c@inspiron>
In-Reply-To: <20051220214511.12bbb69c@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512202101.39498.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 20 December 2005 15:45, Alessandro Zummo wrote:
> +int rtc_read_time(struct class_device *class_dev, struct rtc_time *tm)
> +{
> +       int err = -EINVAL;
> +       struct rtc_class_ops *ops = class_get_devdata(class_dev);
> +
> +       if (ops->read_time) {
> +               memset(tm, 0, sizeof(struct rtc_time));
> 

What guarantees that ops is not NULL here? Userspace can keep the
attribute (file) open and issue read after class_device was unregistered
and devdata set to NULL.

-- 
Dmitry

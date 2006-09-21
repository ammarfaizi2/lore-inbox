Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWIUH4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWIUH4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWIUH4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:56:31 -0400
Received: from mx0.towertech.it ([213.215.222.73]:41436 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751032AbWIUH4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:56:30 -0400
Date: Thu, 21 Sep 2006 09:56:19 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RTC] Remove superfluous call to call to cdev_del()
Message-ID: <20060921095619.0b2f1774@inspiron>
In-Reply-To: <200609210946.06924.eike-kernel@sf-tec.de>
References: <200609210946.06924.eike-kernel@sf-tec.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 09:46:06 +0200
Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> If cdev_add() fails there is no good reason to call cdev_del().
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>
>  	rtc->char_dev.owner = rtc->owner;
>  
>  	if (cdev_add(&rtc->char_dev, MKDEV(MAJOR(rtc_devt), rtc->id), 1)) {
> -		cdev_del(&rtc->char_dev);
>  		dev_err(class_dev->dev,
>  			"failed to add char device %d:%d\n",
>  			MAJOR(rtc_devt), rtc->id);

 I'm not sure.. this is drivers/char/raw.c:


 cdev_init(&raw_cdev, &raw_fops);
        if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
                kobject_put(&raw_cdev.kobj);
                unregister_chrdev_region(dev, MAX_RAW_MINORS);
                goto error;
        }

 in case of failure, it does a kobject_put.
 tha same call is done by cdev_del.

 other drivers have implemented different error paths.
 which one is correct?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


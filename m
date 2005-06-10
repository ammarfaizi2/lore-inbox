Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFJT5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFJT5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFJT5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:57:19 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:49784 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261195AbVFJT5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:57:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gy3pWbpHq7pYHJiA4MwTZ4cdj8ZiRSw0d7Sj1Wk5YDg9+eRmwthtNcn/UEMy0JJ7DlN2rdKzOzDa9ljW/kkP/KbEH2bzXrS/4O5EHO/uxDvVtHhKKUvnSB+LGnNZJBxD9fD0+D9E5Gj8UXGtSRRO2nW67P7pm7UhXDHV9D+8wi0=
Message-ID: <d120d50005061012571c2e58a0@mail.gmail.com>
Date: Fri, 10 Jun 2005 14:57:11 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@dell.com, ranty@debian.org
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3BC@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <367215741E167A4CA813C8F12CE0143B3ED3BC@ausx2kmpc115.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/05, Abhay_Salunke@dell.com <Abhay_Salunke@dell.com> wrote:
> I tired to do the following
> 1. echo 0 > /sys/class/firmware/timeout
> 2. modify the firmware.agent by commenting echo -1 when file is not
> present as below.
> 
>    if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
>        echo 1 > $SYSFS/$DEVPATH/loading
>        cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
>        echo 0 > $SYSFS/$DEVPATH/loading
>    else
>   #     echo -1 > $SYSFS/$DEVPATH/loading
>    Fi
> 3. load the dell_rbu driver : see dell_rbu code snipped below
> 
> device_initialize(&rbu_device);
> 
> strncpy(rbu_device.bus_id,"dell_rbu", BUS_ID_SIZE);
> 

I think if you add:

        kobject_set_name(&rbu_device.kobj, "%s", rbu_device.bus_id,"dell_rbu");

it will work much better. Also, are you initializing rbu_device with
all 0 to begin with?

-- 
Dmitry

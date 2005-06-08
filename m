Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFHQA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFHQA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFHQAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:00:24 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:17424 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261337AbVFHP4V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:56:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qts33ELIR9aBLa+94mOI2XmHji/tH79O/TmwlOQQ9sOsyh7D44BKdcR1FdVXk0NSCd0wY8qRZY8CZEEX12X57mX2x73Euu8yDaOE857AEMuGMySr3j+ZAfRr802ibuXNsUi34Sk8SV6Al5F8LxW7/3jPg7YjnredhIqJZ+NEfKs=
Message-ID: <d120d50005060808565a7944f2@mail.gmail.com>
Date: Wed, 8 Jun 2005 10:56:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Abhay Salunke <Abhay_Salunke@dell.com>
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       abhay_salunke@dell.com, matt_domsch@dell.com, Greg KH <greg@kroah.com>,
       Manuel Estrada Sainz <ranty@debian.org>
In-Reply-To: <20050608151744.GA12180@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050608151744.GA12180@littleblue.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Abhay Salunke <Abhay_Salunke@dell.com> wrote:
> This is a patch with modifications in firmware_class.c to have no hotplug
> support.
...

> @@ -87,7 +87,7 @@ static struct class firmware_class = {
>        .name           = "firmware",
>        .hotplug        = firmware_class_hotplug,
>        .release        = fw_class_dev_release,
> -};
> +};

Adds trailing whitespace.
> @@ -364,6 +364,7 @@ fw_setup_class_device(struct firmware *f
>                printk(KERN_ERR "%s: class_device_create_file failed\n",
>                       __FUNCTION__);
>                goto error_unreg;
> +r

What is this?
> -out:
> -       return retval;
> +       return _request_firmware(firmware_p, name, device, FW_DO_HOTPLUG);
>  }

Tab vs. space identation.

>  /* Async support */
>  struct firmware_work {
>        struct work_struct work;
> -       struct module *module;
> +       struct module *module;
>        const char *name;
>        struct device *device;
>        void *context;
> +       int hotplug;
>        void (*cont)(const struct firmware *fw, void *context);
>  };

I think it would be better if you just have request_firmware and
request_firmware_nowait accept timeout parameter that would override
default timeout in firmware_class. 0 would mean use default,
MAX_SCHED_TIMEOUT - wait indefinitely.

-- 
Dmitry

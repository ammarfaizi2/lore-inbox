Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWCVVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWCVVXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWCVVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:23:11 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:56743 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932748AbWCVVXJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:23:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kLwah+DZYpFkFk6hX0H5Y4ipzWEWvBHfm5XoanyVPR0XCWYjz8gSoUCDPzZvWjiDmcs/FmMJvXqKXX9YHOgH+BAg1shR1NP5+keaYb1aP83FWEVJf0hirk4dzMQyPQSTBaoGi0Q1YUCQTMufXX8SIwHc2d6/lEa4/sCjfRmJltI=
Message-ID: <d120d5000603221323t7c67b06epa02ed3269d3365b0@mail.gmail.com>
Date: Wed, 22 Mar 2006 16:23:08 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: minyard@acm.org
Subject: Re: [PATCH] Try 2, Fix release function in IPMI device model
Cc: "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Yani Ioannou" <yani.ioannou@gmail.com>, greg@kroah.com
In-Reply-To: <20060322204501.GA21213@i2.minyard.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322204501.GA21213@i2.minyard.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Corey Minyard <minyard@acm.org> wrote:
>
>  struct bmc_device
>  {
> -       struct platform_device dev;
> +       struct platform_device *dev;
>        struct ipmi_device_id  id;
>        unsigned char          guid[16];
>        int                    guid_set;
> -       int                    interfaces;
> +
> +       struct kref            refcount;
>

Hi,

I am confused as to why you need kref here. Just unregister/kfree
memory occupied by your device structure after doing
platform_device_unregister and that's it. platform code won't
reference your memory and your attribute code should not be called
from module exit code so everything shoudl be fine.

--
Dmitry

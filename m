Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbULLXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbULLXrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbULLXrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:47:51 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:46191 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262174AbULLXrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:47:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oIcp6gydFX7IkPsKkAz5gzEgpT54Y5kg+gD+rIxW1vulyHCYy3TtD1eb41nwdKMt8yZvzY+fAI8Uqk3ql7khtIOpk1z6nX5i7Anqj53GmqFRW6JCJayMcIWvFtD86yr4GAaZeHRlHroT0aWjzYgeMBdddD9opBMYbcUIaiQCNDg=
Message-ID: <29495f1d0412121547c0c644d@mail.gmail.com>
Date: Sun, 12 Dec 2004 15:47:44 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Little rework of usbserial in 2.4
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net, rwhite@casabyte.com,
       linux-kernel@vger.kernel.org, kingst@eecs.umich.edu,
       paulkf@microgate.com, oleksiy@kharkiv.com.ua, reg@dwf.com,
       clemens@dwf.com
In-Reply-To: <20041127173558.4011b177@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041127173558.4011b177@lembas.zaitcev.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004 17:35:58 -0800, Pete Zaitcev <zaitcev@redhat.com> wrote:
> Hi, Greg, hi, guys:

<snip>

> diff -urpN -X dontdiff linux-2.4.28-bk3/drivers/usb/serial/usbserial.c linux-2.4.28-bk3-sx4/drivers/usb/serial/usbserial.c
> --- linux-2.4.28-bk3/drivers/usb/serial/usbserial.c     2004-11-22 23:04:19.000000000 -0800
> +++ linux-2.4.28-bk3-sx4/drivers/usb/serial/usbserial.c 2004-11-27 10:36:49.000000000 -0800

<snip>

> @@ -1803,6 +1820,12 @@ static void __exit usb_serial_exit(void)
> 
>         usb_deregister(&usb_serial_driver);
>         tty_unregister_driver(&serial_tty_driver);
> +
> +       while (!list_empty(&usb_serial_driver_list)) {
> +               err("%s - module is in use, hanging...\n", __FUNCTION__);
> +               set_current_state(TASK_UNINTERRUPTIBLE);
> +               schedule_timeout(5*HZ);
> +       }

Please consider using msleep() here instead of schedule_timeout().

Thanks,
Nish

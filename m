Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbULUUxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbULUUxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULUUxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:53:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261854AbULUUxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 15:53:10 -0500
Date: Tue, 21 Dec 2004 12:52:22 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net, rwhite@casabyte.com,
       linux-kernel@vger.kernel.org, kingst@eecs.umich.edu,
       paulkf@microgate.com, oleksiy@kharkiv.com.ua, reg@dwf.com,
       clemens@dwf.com
Subject: Re: Little rework of usbserial in 2.4
Message-ID: <20041221125222.5754cdb2@lembas.zaitcev.lan>
In-Reply-To: <29495f1d0412121547c0c644d@mail.gmail.com>
References: <20041127173558.4011b177@lembas.zaitcev.lan>
	<29495f1d0412121547c0c644d@mail.gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 15:47:44 -0800, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:

> > diff -urpN -X dontdiff linux-2.4.28-bk3/drivers/usb/serial/usbserial.c linux-2.4.28-bk3-sx4/drivers/usb/serial/usbserial.c
> > --- linux-2.4.28-bk3/drivers/usb/serial/usbserial.c     2004-11-22 23:04:19.000000000 -0800

> > @@ -1803,6 +1820,12 @@ static void __exit usb_serial_exit(void)
> > 
> >         usb_deregister(&usb_serial_driver);
> >         tty_unregister_driver(&serial_tty_driver);
> > +
> > +       while (!list_empty(&usb_serial_driver_list)) {
> > +               err("%s - module is in use, hanging...\n", __FUNCTION__);
> > +               set_current_state(TASK_UNINTERRUPTIBLE);
> > +               schedule_timeout(5*HZ);
> > +       }

> Please consider using msleep() here instead of schedule_timeout().

No, Nish, it's 2.4. There's no msleep here. I can create something like
"drivers/usb/serial/compat26.h", similar to include/linux/libata-compat.h,
but I do not think it's worth the trouble at present juncture.

-- Pete

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbULVQHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbULVQHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbULVQHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:07:22 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:64358 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262004AbULVQHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:07:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=s4vmJHBD05RGAv2GeOKD1ZN81A3iVar01gsOC0Zwic/OgYXWDYb4p/p5LxvhaDWB7sfyvC3/iIF7G4B4dKLsU2aNJiPERCSzMEWerzB1M70eYMsCHZimeHau4Cdy1iWMXibCU7vC0fyQRKdtztsVGGrMWEpRoEThdJdOdaOZOKc=
Message-ID: <29495f1d04122208073d71914b@mail.gmail.com>
Date: Wed, 22 Dec 2004 11:07:08 -0500
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Little rework of usbserial in 2.4
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net, rwhite@casabyte.com,
       linux-kernel@vger.kernel.org, kingst@eecs.umich.edu,
       paulkf@microgate.com, oleksiy@kharkiv.com.ua, reg@dwf.com,
       clemens@dwf.com
In-Reply-To: <20041221125222.5754cdb2@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041127173558.4011b177@lembas.zaitcev.lan>
	 <29495f1d0412121547c0c644d@mail.gmail.com>
	 <20041221125222.5754cdb2@lembas.zaitcev.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004 12:52:22 -0800, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Sun, 12 Dec 2004 15:47:44 -0800, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> 
> > > diff -urpN -X dontdiff linux-2.4.28-bk3/drivers/usb/serial/usbserial.c linux-2.4.28-bk3-sx4/drivers/usb/serial/usbserial.c
> > > --- linux-2.4.28-bk3/drivers/usb/serial/usbserial.c     2004-11-22 23:04:19.000000000 -0800
> 
> > > @@ -1803,6 +1820,12 @@ static void __exit usb_serial_exit(void)
> > >
> > >         usb_deregister(&usb_serial_driver);
> > >         tty_unregister_driver(&serial_tty_driver);
> > > +
> > > +       while (!list_empty(&usb_serial_driver_list)) {
> > > +               err("%s - module is in use, hanging...\n", __FUNCTION__);
> > > +               set_current_state(TASK_UNINTERRUPTIBLE);
> > > +               schedule_timeout(5*HZ);
> > > +       }
> 
> > Please consider using msleep() here instead of schedule_timeout().
> 
> No, Nish, it's 2.4. There's no msleep here. I can create something like
> "drivers/usb/serial/compat26.h", similar to include/linux/libata-compat.h,
> but I do not think it's worth the trouble at present juncture.

I agree that it's not worth the trouble. Sorry, I was under the
impression that Kernel-Janitors had pushed a series of patches to
backport msleep(). Maybe they haven't made it to mainline yet. Sorry
for the noise.

-Nish

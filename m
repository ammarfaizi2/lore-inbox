Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWAICEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWAICEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWAICEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:04:04 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:39297 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S1751292AbWAICED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:04:03 -0500
Date: Mon, 9 Jan 2006 03:04:33 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] RTC subsystem, proc interface
Message-ID: <20060109030433.581c49e7@inspiron>
In-Reply-To: <200601082056.30227.dtor_core@ameritech.net>
References: <20060108231235.153748000@linux>
	<20060108231255.274262000@linux>
	<200601082056.30227.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 20:56:29 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> > +static void rtc_proc_remove_device(struct class_device *class_dev,
> > +                                             struct class_interface *class_intf)
> > +{
> > +       down(&rtc_sem);
> > +       if (rtc_dev == class_dev) {
> > +               remove_proc_entry("driver/rtc", NULL);
> > +               rtc_dev = NULL;
> > +       }
> > +       up(&rtc_sem);
> > +}
> 
> What if I happen to remove (unregister) rtc devices in order other
> than they were registered in? You need a counter there instead of
> storing the first device created.

 Only the first device that registers will get the /proc/driver/rtc
 entry, which will be removed when the driver unregisters.

 /proc/driver/rtc is a legacy interface, thus supporting it
 for more than one RTC is useless. Any system that uses
 more than one RTCs should access them via /dev/rtcX or
 via sysfs.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


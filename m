Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbTIAHK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTIAHK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:10:27 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:25576 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262653AbTIAHK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:10:26 -0400
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF1FB5D4CF.BD211436-ONC1256D94.0026F8D1-C1256D94.00275806@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 1 Sep 2003 09:09:44 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 01/09/2003 09:10:15
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > @@ -537,8 +537,7 @@
< >          init_timer(&cdev->private->timer);
> >
> >          /* Set an initial name for the device. */
> > -        snprintf (cdev->dev.name, DEVICE_NAME_SIZE,"ccw device");
> > -        snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
> > +        snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x",
> >                        sch->schib.pmcw.dev);
> >
> >          /* Increase counter of devices currently in recognition. */
>
> Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?

Yes, indeed. DEVICE_NAME_SIZE is 32 and BUS_ID_SIZE is 20. Luckily the
printed string is always shorter than 20 byte but nevertheless its wrong
to use DEVICE_ID_SIZE. Thanks for the hint.

blue skies,
   Martin



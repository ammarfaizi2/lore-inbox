Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRDBT2O>; Mon, 2 Apr 2001 15:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131270AbRDBT2F>; Mon, 2 Apr 2001 15:28:05 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:25860 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131261AbRDBT1v>; Mon, 2 Apr 2001 15:27:51 -0400
Message-Id: <200104021926.f32JQxs89810@aslan.scsiguy.com>
To: Admin Mailing Lists <mlist@intergrafix.net>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
   aic7xxx@FreeBSD.ORG
Subject: Re: aic7xxx TCQ settings? 
In-Reply-To: Your message of "Mon, 02 Apr 2001 15:16:34 EDT."
             <Pine.LNX.4.10.10104021509450.32252-100000@athena.intergrafix.net> 
Date: Mon, 02 Apr 2001 13:26:59 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'm using 2.4.3 vanilla with aic7xxx (aic7880 onboard)
>I set the max # of TCQ commands per device setting to 50..what's a really
>good setting for this, just the default of 253?

Depends on the device.  The aic7xxx driver will determine the
maximum number of tags that a particular device can handle and limit
the transactions accordingly.  For devices with now hard limit, transactions
will be dynamically varied to limit the occurrance of queue full but
to otherwise try to keep the limit as high as possible.  Some devices
do not perform well when lots of transactions are outstanding even though
they never report queue full.  On these devices, you will get better
performance if you lower your transaction settings.

>
>In /proc/scsi/aic7xxx/0 i see for my drives these numbers:
>	Commands Queued 140000

This is a count of the number of commands ever queued to the device.
The only time it will "decrease" is when the counter wraps to 0.
The counter, at least in the 6.1.8 driver, is an unsigned long.

>	Commands Active 0

This is a count of the number of commands currently outstanding to the
device.  You system was idle, SCSI wise, when you pulled this information.

>	Command Openings 253

Current "soft limit" on tagged transactions.  We've never seen a queue full
from this device, so the tag count has not been reduced from its original
setting.

>	Max Tagged Openings 253

Hard limit on the number of tagged transactions.  The hard limit is
set by monitoring the device's "queue full" behavior.

--
Justin

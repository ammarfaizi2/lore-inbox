Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTDESXv (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTDESXv (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:23:51 -0500
Received: from mcomail02.maxtor.com ([134.6.76.16]:4877 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S261966AbTDESXr (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 13:23:47 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D066@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Andre Hedrick '" <andre@linux-ide.org>,
       "'Chuck Ebbert '" <76306.1226@compuserve.com>
Cc: "'linux-kernel '" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: Fixes for ide-disk.c
Date: Sat, 5 Apr 2003 11:34:48 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you guys see a problem with how the bits are set on a Maxtor drive,
please let me know so I can fix them.

If you try to spin down, the drive shouldn't allow that to happen with dirty
write data, period.

To ensure the cache is flushed, you must issue FLUSH CACHE (EXT).  That is
the only "according to spec" method.  I know of other things you can do (on
a Maxtor drive) that have cache flush as a side effect, but that is the only
specified way.

Once the flush cache has returned 0x50 status, there can be no dirty data
left in the drive.  Note that this FLUSH CACHE can easily take 6-10 seconds
depending on drive cache size and workload pattern.

 

-----Original Message-----
From: Andre Hedrick
To: Chuck Ebbert
Cc: linux-kernel
Sent: 4/5/03 4:30 AM
Subject: Re: PATCH: Fixes for ide-disk.c


If the drive is compliant it will issue an abort if not supported.
Otherwise one should check the identify page; however, there are several
cases where the bits are improperly set.  Another double edge sword to
make the driver more interesting.

Cheers,

On Sat, 5 Apr 2003, Chuck Ebbert wrote:

> 
> John Bradford wrote:
> 
> 
> >Did we ever establish what the best way to ensure
> >that the write cache is flushed, is?  An explicit
> >cache flush and spin down are both necessary, but
> >I had problems with drives spinning back up when
> >we did the spindown first.
> 
> 
> Disks that don't support flush should be sent an IDLE command, IIRC.
> 
> 
> 
> --
>  Chuck
>  I am not a number!
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272905AbRIGXhb>; Fri, 7 Sep 2001 19:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272906AbRIGXhU>; Fri, 7 Sep 2001 19:37:20 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:40199 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272905AbRIGXhI>; Fri, 7 Sep 2001 19:37:08 -0400
Message-Id: <200109072337.f87NbPY92715@aslan.scsiguy.com>
To: SPATZ1@t-online.de (Frank Schneider)
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors) 
In-Reply-To: Your message of "Sat, 08 Sep 2001 00:51:32 +0200."
             <3B994F74.F97196BC@t-online.de> 
Date: Fri, 07 Sep 2001 17:37:25 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You need to be running with aic7xxx=verbose for these messages to be
>> useful.  In the 6.2.2 driver release I've turned these messages on
>> by default.
>
>Could you please shortly explain what this option does...(before it
>fills my logfiles with notes "succesfully wrote 1 Byte to disk abc"..:-)

It turns on some diagnostics regarding:

1) Card initialization
2) Transfer Negotiation (occurs with every check condition that occurs
			 prior to sending data, so while not rare, is
			 not a common occurrence).
3) Abort/Timeout processing

It should not fill your log file unless you have a timeout.  This is
exactly the time you want it to fill your logs, so I can help diagnose
and fix your problem.

>> This is 8 times the tag load the old driver defaults to.
>
>Thats true, and e.g., my relatively new IBM-drives (DGHS18V, 2x
>DNES-309170W,  DDRS-39130W, all Server-disks according to IBM) can only
>64...and the kernel complains, if i compile it with 255 and locks to
>64...

Its not really "complaining", its just telling you that it has determined
the proper setting for this device.  There is an advantage to setting
your tag depth to the locked value - the SCSI layer cannot be told
dynamically to lower the tag depth, so there may be extra transactions
sitting in the driver queue for no real purpose - but its not that
big of a deal.

>as i have played with this feature a while ago, i did not realize a
>big performance-plus from 8 to 64, so i switched to 32...and i would go
>down to <8 if i where in doubt....

It all depends on your workload.  If you run a news server or have lots
of concurrent active users on the machine, you are more likely to see
a difference.

--
Justin

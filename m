Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270037AbRHUAg6>; Mon, 20 Aug 2001 20:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270025AbRHUAgs>; Mon, 20 Aug 2001 20:36:48 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:54538 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S270035AbRHUAgj>; Mon, 20 Aug 2001 20:36:39 -0400
Message-Id: <200108210036.f7L0amY45964@aslan.scsiguy.com>
To: Cliff Albert <cliff@oisec.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo 
In-Reply-To: Your message of "Tue, 21 Aug 2001 00:55:46 +0200."
             <20010821005546.A29315@oisec.net> 
Date: Mon, 20 Aug 2001 18:36:48 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IIRC, the problem has to do with the state of the write cache in the drive.
>> The cache will be in a different state after power-on as compared to
>> after some amount of activity.
>
>Well i still suspect the broken firmware of the disk isn't the only cause of
>these errors

Perhaps.

One thing to keep in mind however is that, although the messages may
*look* the same, they very rarely are.  If you don't have verbose turned
on, all transaction timeouts, regardless of the reason, look the same.
It is only by analyzing the verbose output that a cause for a particular
problem can be found.  In the case of your system, we always timeout
with the bus idle with several pending transaction, we can always abort
a transaction successfully (i.e. the bus is not dead, neither is the
target), its just that some transactions never complete.  These are
exactly the symptoms of the bogus FireBall ST firmware on your drive.

Another thing to keep in mind...  The newer driver defaults to using
tagged queing and attempts to issue the maximum number of concurrent
transactions possible to each device.  The old driver, until fairly
recently, defaulted to leaving tagged queuing disabled, and if enabled,
only queued 8 transactions.  So, the new aic7xxx driver often places
a much higher load on your SCSI setup than the old one did.  I think
this has something to do with the large number of reports.

This doesn't mean that there haven't been, or continue to be  bugs.
After all this is software, but I am trying to do my best to make
it work. 8-)

--
Justin

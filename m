Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRIJWnD>; Mon, 10 Sep 2001 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272088AbRIJWmx>; Mon, 10 Sep 2001 18:42:53 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:46354 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272079AbRIJWmg>; Mon, 10 Sep 2001 18:42:36 -0400
Message-Id: <200109102242.f8AMgpY21341@aslan.scsiguy.com>
To: Andreas Steinmetz <ast@domdv.de>
cc: SPATZ1@t-online.de (Frank Schneider),
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors) 
In-Reply-To: Your message of "Tue, 11 Sep 2001 00:29:24 +0200."
             <XFMail.20010911002924.ast@domdv.de> 
Date: Mon, 10 Sep 2001 16:42:51 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Something other made me wonder:
>> I ran the machine several times with the *new* aic7xxx-driver (TCQ=32)
>> and the "aic7xxx=verbose" commandline, and i noticed the following:
>> At every reboot (made by "reboot", RH7.1), the machine was not able to
>> stop the raid5 correctly...it un-mounted the mountpoint (/home) and then
>> it normaly wants to stop the raid...(you see the messages "mdrecoveryd
>> got waken up...") but that did not work and after some time (30sec) the
>> kernel Ooopsed.

...

>Same behaviour for RAID1 and the new aic7xxx driver for me at nearly every
>reboot. The old driver works just fine (2.4.9).

The new driver registers a "reboot notifier" with the system.  If MD
continues to perform I/O after the aic7xxx driver's notification routine
is called, the result is undefined.  The aic7xxx driver has already
shutdown the hardware.  Perhaps I should use a different event to indicate
it is safe for me to clean up the hardware?

--
Justin

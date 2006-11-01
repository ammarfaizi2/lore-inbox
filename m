Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946504AbWKACda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946504AbWKACda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946508AbWKACda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:33:30 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:44222 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946504AbWKACd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:33:28 -0500
Message-ID: <45480777.6070908@vmware.com>
Date: Tue, 31 Oct 2006 18:33:27 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Mark Lord <lkml@rtr.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 is problematic in VMware
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr> <45463B7D.8050002@vmware.com> <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr> <4547584F.6000702@rtr.ca> <Pine.LNX.4.61.0610311551370.6900@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610311551370.6900@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> My experience with VMware on several recent processors (mostly P-M family)
>> is that it crawls unless I force this first:
>> echo 1 > /sys/module/processor/parameters/max_cstate
>>     
>
> My host processor is non-throttable
> Uni-processor.
>
> I tried with some kernels (hey, vmware had serial ports?)
> For whatever reason, the timecounting is not accurate.
> As you can see, the time difference between "WP bit" and the calibration 
> thing is less than half a second inside the guest, but on the host, 
> the delay is several seconds.
> The Capture Movie feature gets it right 
> http://jengelh.hopto.org/f/2618delay.avi
>   

I see a large delay _before_:

Calibrating delay using timer specific routine.. (lpj==

The lpj value is 38x the host lpj host value.  Booting with lpj="some 
random number" removes the stall for me.  And finally, breaking into 
kernel in this stall period consistently shows EIPs in calibrate_delay 
in backtrace.

> One can see that it pauses before calibration (already mentioned that) 
> and once again after NET: ... during IP init!? What's going on :(
>   

The NET: pause has always been there, I think it just becomes much more 
noticeable if the lpj value is 38x normal.

Conclusion: you are getting bad lpj computation during beginning.  
Doesn't appear to be a kernel bug, so let's take it off list.  You can 
bring it up on VMTN 
http://www.vmware.com/community/index.jspa?categoryID=1 for more 
on-topic support.  In fact, interesting test you can try - suspend / 
resume during the hang.  Does the discontinuity during calibration make 
it go away?

Zach

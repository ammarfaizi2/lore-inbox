Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCEVLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCEVLD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVCEVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:11:03 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:17596 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261166AbVCEVKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:10:31 -0500
Date: Sat, 05 Mar 2005 16:10:26 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [PATCH] raw1394 missing failure handling
In-reply-to: <20050305184756.GH1111@conscoop.ottawa.on.ca>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051610.26743.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050303214843.GQ1111@conscoop.ottawa.on.ca>
 <20050303225509.GB7442@mech.kuleuven.ac.be>
 <20050305184756.GH1111@conscoop.ottawa.on.ca>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 13:47, Jody McIntyre wrote:
>On Thu, Mar 03, 2005 at 11:55:09PM +0100, Panagiotis Issaris wrote:
>> Adds the missing failure handling for a __copy_to_user call.
>>
>>
>> Signed-off-by: Panagiotis Issaris <takis@gna.org>
>
>Sorry I didn't notice this sooner, but this was already fixed and
> has been sent to Linus (hopefully to appear in 2.6.12.)
>
>Jody

Jody, Panagiotis;  A much more complete patch is already sitting in 
the bk queue.  This is a relatively small piece of that one.  You can 
get it from:

<ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/broken-out>

As the bk-ieee1394.patch you can see there.

>> diff -pruN linux-2.6.11/drivers/ieee1394/raw1394.c
>> linux-2.6.11-pi/drivers/ieee1394/raw1394.c ---
>> linux-2.6.11/drivers/ieee1394/raw1394.c 2005-03-02
>> 11:44:26.000000000 +0100 +++
>> linux-2.6.11-pi/drivers/ieee1394/raw1394.c 2005-03-02
>> 15:27:15.000000000 +0100 @@ -443,7 +443,10 @@ static ssize_t
>> raw1394_read(struct file req->req.error = RAW1394_ERROR_MEMFAULT;
>> }
>>          }
>> -        __copy_to_user(buffer, &req->req, sizeof(req->req));
>> +        if (__copy_to_user(buffer, &req->req, sizeof(req->req)))
>> { +                free_pending_request(req);
>> +                return -EFAULT;
>> +        }
>>
>>          free_pending_request(req);
>>          return sizeof(struct raw1394_request);
>>
>>
>> --
>>   K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research
>> Group http://people.mech.kuleuven.ac.be/~pissaris/
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to
>> majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSK1W1E>; Thu, 28 Nov 2002 17:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSK1W1E>; Thu, 28 Nov 2002 17:27:04 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:32941 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266774AbSK1W1D>;
	Thu, 28 Nov 2002 17:27:03 -0500
Message-ID: <3DE699EC.9060600@colorfullife.com>
Date: Thu, 28 Nov 2002 23:34:20 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Georg Nikodym <georgn@somanetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab
 labels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>> 1. Is the ARM __get_user() broken?
>> 2. Could I be doing something else broken that is confusing __get_user()?
>> 3. What was/is the intent of the test?  Or stated differently, why on earth
>>    would cachep->name be a user address?
>  
>

get_user is the standard test for bad pointers: If the pointer is bad, 
then the exception handler will prevent an oops.

Could you backport the get_fs()/set_fs() calls around the get_user() 
from 2.5? I assume that ARM needs it to distiguish between kernel and 
user addresses.

On i386, it's possible to skip set_fs() and use __get_user() - but 
that's i386 specific. For example the i386 oops code uses that.

--
    Manfred


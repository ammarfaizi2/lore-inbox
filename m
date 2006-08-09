Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030629AbWHIKCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWHIKCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWHIKCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:02:55 -0400
Received: from web25801.mail.ukl.yahoo.com ([217.12.10.186]:52093 "HELO
	web25801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030629AbWHIKCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:02:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=cj66T7o34OsUTdCIn92yRe/cRMujrO3QDI1XxeAfiRaKyDeX6VI4o5axJJTcxpr+GA2bvbpkVQl8Mcs/HGD96ziG7w/O8D4eIZ/ByX+hWvgCBXKJHvR2FAmKwRUAwducY7je1NbWFuHsZC99u5PEslALKChvU7M1vwO24hESGt4=  ;
Message-ID: <20060809100253.78092.qmail@web25801.mail.ukl.yahoo.com>
Date: Wed, 9 Aug 2006 10:02:53 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [HW_RNG] How to use generic rng in kernel space
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608081934.31694.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Tuesday 08 August 2006 17:39, moreau francis wrote:
>> Michael Buesch wrote:
>>> So, if you have a special hwrng on your embedded board and you
>>> have some special driver in that board, why not interface
>>> directly from the driver to the hwrng-driver?
>> This is what I'm currently doing. I was just thinking to use the
>> new HW-RNG layer and drop common code...
>>
>>> This is all pretty special case.
>>> In the hwrng-driver you could still additionally do a
>>> hrwng_register() to export the functionality to
>>> userspace, though.
>>>
>> yes I would like to do that but there is a problem: I have no 
>> access to "rng_mutex" to synchronise hw accesses and I'm
>> wondering if there's any issue to use a mutex in driver init
>> code.
> 
> Use your own mutex or spinlock in the data_read callback
> and use that to serialize accesses to the hardware.
> 

I think I miss something there but I need to lock this whole
sequence when reading a random data:

    lock(hwrng);
    rng_data_present();
    rng_data_read();
    unlock(hwrng);

not only data_read callback. To do that I can only use "rng_mutex",
no ?

thanks

Francis



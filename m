Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVCPM0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVCPM0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCPM0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:26:01 -0500
Received: from alog0049.analogic.com ([208.224.220.64]:16522 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262560AbVCPMZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:25:26 -0500
Date: Wed, 16 Mar 2005 07:23:11 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bogus buffer length check in linux-2.6.11  read()
In-Reply-To: <423776E2.5000801@shaw.ca>
Message-ID: <Pine.LNX.4.61.0503160715400.16304@chaos.analogic.com>
References: <3IoOm-5M2-49@gated-at.bofh.it> <423776E2.5000801@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Robert Hancock wrote:

> linux-os wrote:
>> 
>> The attached file shows that the kernel thinks it's doing
>> something helpful by checking the length of the input
>> buffer for a read(). It will return "Bad Address" until
>> the length is 1632 bytes.  Apparently the kernel thinks
>> 1632 is a good length!
>
> Likely because only 1632 bytes of memory is accessible after the start of the 
> buf buffer, and trying to read in more than that results in copy_to_user 
> failing to write some data.
>

There was NO DATA read or written! The read() call returns immediately
without reading anything. Look at the code, assume nothing. This
is a blocking read from standard-input.

>> 
>> Did anybody consider the overhead necessary to do this
>> and the fact that the kernel has no way of knowing if
>> the pointer to the buffer is valid until it actually
>> does the write. What was wrong with copy_to_user()?
>> Why is there the additional bogus check?
>
> What additional check?
>

Somebody added some very dumb check of the input value
of a read() length that occurs before anything is
actually read.

Previously, a read(), which is a kernel write to user-data
space, would seg-fault if the read exceeded the data-space
that had been mapped. It is done by the CPU, it generates
a trap. The performance cost, when done by the CPU, if
the data doesn't exceed bounds, is zero. Now, there is
a beginning check (a wrong check BTW), in software,
before the data is even obtained from the device.

> -- 
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

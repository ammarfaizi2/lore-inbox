Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUBMXFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267281AbUBMXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:05:05 -0500
Received: from siamese.3ware.com ([67.122.122.226]:63540 "EHLO
	siamese.3ware.com") by vger.kernel.org with ESMTP id S267278AbUBMXEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:04:50 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B8126F8C92C@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Timothy Miller'" <miller@techsource.com>,
       Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: File system performance, hardware performance, ext3, 3ware RA
	ID1, etc.
Date: Fri, 13 Feb 2004 15:07:22 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps you are issuing non purely sequential IO.  The card firmware does
some 
reodering, but at some point it will cause performance degradation.  Can you
try 
kernel 2.6 w/xfs? 

Also, in my experience, the 'raw io' interface doesn't issue any
asynchronous IO.  The
card _definately_ needs asynchronous IO posted to it or you will not get
good results
because you won't get all the drives busy.

-Adam

-----Original Message-----
From: Timothy Miller [mailto:miller@techsource.com]
Sent: Friday, February 13, 2004 2:57 PM
To: Daniel Blueman
Cc: linux-kernel@vger.kernel.org
Subject: Re: File system performance, hardware performance, ext3, 3ware
RAID1, etc.




Daniel Blueman wrote:
> Willy Tarreau <willy@w.ods.org> wrote in message
> news:<1oEGw-2ex-1@gated-at.bofh.it>...
> 
>>On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:
>> 
>>
>>>For writes, iozone found an upper bound of about 10megs/sec, which is 
>>>abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
>>>than reads, because once the write is sent, you can forget about it. 
>>>You don't have to wait around for something to come back, and that 
>>>latency for reads can hurt performance.  The OS can also buffer writes 
>>>and reorder them in order to improve efficiency.
>>
>>It depends on the disk too. Lots of disks (specially IDE) are far slower
>>on writes than they are on reads.
> 
> 
> No. Have you verified this? If you 'dd' your swap partition from /dev/zero
> on IDE, you'll see write performance closely matches read performance, for
> drives old and new.
> 

And this sort of things is what I find with raw writes to the model of 
drive I'm using.  However, it seems that there must be some issue with 
the 3ware 7000-2 which is killing performance, or the way the Linux 
kernel is dealing with this sorta-SCSI device.

The WD1200JB should get like 30-40 megs/sec, but when being accessed 
through the 3ware, I get 10-16 megs/sec.

What could the 3ware be doing?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


DISCLAIMER: The information contained in this electronic mail transmission
is intended by 3ware for the use of the named individual or entity to which
it is directed and may contain information that is confidential or
privileged and should not be disseminated without prior approval from 3ware 



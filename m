Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWGEV1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWGEV1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWGEV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:27:04 -0400
Received: from spirit.analogic.com ([204.178.40.4]:59397 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965036AbWGEV1D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:27:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 05 Jul 2006 21:27:02.0039 (UTC) FILETIME=[C1410A70:01C6A079]
Content-class: urn:content-classes:message
Subject: Re: ext4 features
Date: Wed, 5 Jul 2006 17:27:01 -0400
Message-ID: <Pine.LNX.4.61.0607051717190.5736@chaos.analogic.com>
In-Reply-To: <44AC2B56.8010703@tmr.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ext4 features
thread-index: AcagecFKVDT3oHwaSlO+eM+EqZVT+w==
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com> <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Theodore Tso" <tytso@mit.edu>,
       "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>,
       "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jul 2006, Bill Davidsen wrote:

> J. Bruce Fields wrote:
>
>> On Wed, Jul 05, 2006 at 08:24:29AM -0400, Bill Davidsen wrote:
>>
>>
>>> Theodore Tso wrote:
>>>
>>>
>>>> Some of the ideas which have been tossed about include:
>>>>
>>>> 	* nanosecond timestamps, and support for time beyond the 2038
>>>>
>>>>
>>> The 2nd one is probably more urgent than the first. I can see a general
>>> benefit from timestamp in ms, beyond that seems to be a specialty
>>> requirement best provided at the application level rather than the bits
>>> of a trillion inodes which need no such thing.
>>>
>>>
>>
>> What's urgently needed for NFS (and I suspect for most other
>> applications demanding higher timestamps) isn't really nanosecond
>> precision so much as something that's guaranteed to increase whenever
>> the file changes.
>>
>> Of course, just adding space in the inodes for nanoseconds isn't
>> sufficient.  XFS, for example, has nanosecond timestamps, but it's still
>> easy to modify a file twice without seeing the ctime or mtime change.
>> So either we need a timesource guaranteed to tick faster than the kernel
>> can process IO, or we have to be willing to, say, add 1 to the
>> nanoseconds field whenever the time doesn't change between operations.
>>
>> Or we could add an entirely separate attribute that's guaranteed to
>> increase whenever the ctime is updated, and that doesn't necessarily
>> have any connection with time--call it a version number or something.
>>
>>
> There are versions in both VMS and the ISO filesystem. I have a sneaking
> suspicion that those of us who ever use them are few and far between.
> The other issue is that unless the field is time, programs like make
> can't really use it, at least without becoming Linux specific.
>
> I'm not sure exactly how a "version" value would be used other than
> detecting the fact that the file had been changed in some way. Feel free
> to show me, I seem to come up empty on using this value.
>
> --
> bill davidsen <davidsen@tmr.com>
>  CTO TMR Associates, Inc
>  Doing interesting things with small computers since 1979

Currently a version is just a convention for not deleting on create.
Remember VAX/VMS  MYFILE.TXT;1, create another one, you have
MYFILE.TXT;2. They are not related in any way. Any internal
value won't be much use if Unix semantics are retained because
multiple directory entries pointing to the same file are just
links. And identical names, pointing to different files in
the same directory are prevented as well.

Maybe the 'version' is the number of times the file has been
modified since creation. This might be useful.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

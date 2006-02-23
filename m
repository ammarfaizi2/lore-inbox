Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWBWMxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWBWMxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWBWMxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:53:05 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:50954 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751166AbWBWMxE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:53:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
x-originalarrivaltime: 23 Feb 2006 12:53:00.0028 (UTC) FILETIME=[1374A3C0:01C63878]
Content-class: urn:content-classes:message
Subject: Re: question about possibility of data loss in Ext2/3 file system
Date: Thu, 23 Feb 2006 07:52:59 -0500
Message-ID: <Pine.LNX.4.61.0602230746330.14181@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question about possibility of data loss in Ext2/3 file system
Thread-Index: AcY4eBN+v85csZgYTDqWQCWh6Tj53g==
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com> <1140645651.2979.79.camel@laptopd505.fenrus.org> <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Feb 2006, Xin Zhao wrote:

> Apparently the scheme you described helps improve the file integrity.
> But still not good enough. For example, if all data blocks are
> flushed, then you will update the metadata. But right after you update
> the block bitmap and before you update the inode, you lose power. You
> will get some dead blocks.  Right? Do you know how ext2/3 deal with
> this situation?
>
> Also, the scheme you mentioned is just for new file creation. What
> will happen if I want to update an existing file? Say, I open file A,
> seek to offset 5000, write 4096 bytes, and then close. Do you know how
> ext2/3 handle this situation?
>
> Many thanks for your kind help!
>
> Xin

Don't "top-post" please.

File-systems are not reliable. None of them are. Some people
make their livings designing databases and database software
so that data are secure using unreliable file-systems. You
may need to study how that is done. It's a multi-step process
so that if at any instant the system should crash or power
should fail, transactions can be restarted from the last
completed one.

The ext3 file-system is a journaling file-system in which
some of the data-base methods are embedded within the file-
system itself. This makes it more reliable, but not really
reliable from the absolute meaning of the word.

>
> On 2/22/06, Arjan van de Ven <arjan@infradead.org> wrote:
>> On Wed, 2006-02-22 at 16:56 -0500, Xin Zhao wrote:
>>> As far as I know, in Ext2/3 file system, data blocks to be flushed to
>>> disk are usually marked as dirty and wait for kernel thread to flush
>>> them lazily. So data blocks of a file could be flushed even after this
>>> file is closed.
>>>
>>> Now consider this scenario: suppose data block 2,3 and 4 of file A are
>>> marked to be flushed out. At time T1, block 2 and 3 are flushed, and
>>> file A is closed. However, at time T2, system experiences power outage
>>> and failed to flushed block 4. Does that mean we will end up with
>>> getting a partially flushed file?  Is there any way to provide better
>>> guarantee on file integrity?
>>
>> on ext3 in default mode it works a bit different
>>
>> if you write a NEW file that is
>>
>> then first the data gets written (within like 5 seconds, and not waiting
>> for the lazy flush daemon). Only when that is done is the metadata (eg
>> filesize on disk) updated. So after the power comes back you don't see a
>> mixed thing; you see a file of a certain size, and all the data upto
>> that size is there.
>>
>> If you need more guarantees you need to use fsync/fdata_sync from the
>> application.
>>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

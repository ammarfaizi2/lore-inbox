Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161815AbWKOWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161815AbWKOWDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161817AbWKOWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:03:38 -0500
Received: from spirit.analogic.com ([204.178.40.4]:27149 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1161815AbWKOWDg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:03:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 15 Nov 2006 22:03:35.0503 (UTC) FILETIME=[E599D5F0:01C70901]
Content-class: urn:content-classes:message
Subject: Re: locking sectors of raw disk (raw read-write test of mounted disk)
Date: Wed, 15 Nov 2006 17:03:34 -0500
Message-ID: <Pine.LNX.4.61.0611151654560.17009@chaos.analogic.com>
In-Reply-To: <455B8979.6090101@cfl.rr.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: locking sectors of raw disk (raw read-write test of mounted disk)
thread-index: AccJAeXARG488GJ1Ruy05r52lVqryw==
References: <f36b08ee0611151206k50284ef9n43d7edf744ae2f19@mail.gmail.com> <455B8979.6090101@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Yakov Lerner" <iler.ml@gmail.com>,
       "Kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Nov 2006, Phillip Susi wrote:

> No, you can not tamper with the underlying data while the kernel has it
> mounted.
>
> Yakov Lerner wrote:
>> I'd like to make read-write test of the raw disk, and disk has
>> mounted partitions. Is it possible to lock  range of sectors
>> of the raw device so that any kernel code that wants to write
>> to this range will sleep ? (so that test
>>    { lock range; read /dev/hda->buf; write buf->/dev/hda; unlock }
>> won't corrupt the filesysyem ?)
>>
>> Thanks
>> Yakov
>

Well certainly if the low-level driver was modified, or a new one
created, so that one could lock/unlock a range of sectors, then that
would be possible. You would need to save (somewhere) the original
sector data, then put it back before unlocking that range. You couldn't
save the original data in a file on the disk, because that file-data
may (someday) extend into the locked region and you have a deadlock.

In the "good old days" when a SCSI format block command actually
worked, we could repair bad sectors by doing just that. We would
lock the block, save whatever data was readable in that block,
format that block, write the data back, then release the lock.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUG2FUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUG2FUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 01:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUG2FUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 01:20:21 -0400
Received: from fmr12.intel.com ([134.134.136.15]:19405 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264238AbUG2FUN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 01:20:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: -mm swsusp: do not default to platform/firmware
Date: Thu, 29 Jul 2004 13:19:05 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F03712639@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: -mm swsusp: do not default to platform/firmware
Thread-Index: AcR1Hkl7hGiGe2J1TQSxavyjwU0iQwADEG9A
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <ncunningham@linuxmail.org>
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "Patrick Mochel" <mochel@digitalimplant.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2004 05:18:57.0307 (UTC) FILETIME=[8C6ACEB0:01C4752B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Nigel Cunningham
>Sent: Thursday, July 29, 2004 8:30 AM
>To: Pavel Machek
>Cc: Andrew Morton; Patrick Mochel; akpm@zip.com.au; Linux Kernel
Mailing
>List
>Subject: Re: -mm swsusp: do not default to platform/firmware
>
>Hi.
>
>On Thu, 2004-07-29 at 09:43, Pavel Machek wrote:
>> +I did found some kernel threads don't do it, and they don't freeze,
and
>
>"I found... threads that don't..."
>
>> +so the system can't sleep. Is this a known behavior?
>> +
>> +A: All such kernel threads need to be fixed, one by one. Select
place
>> +where it is safe to be frozen (no kernel semaphores should be held
at
>> +that point and it must be safe to sleep there), and add:
>> +
>> +            if (current->flags & PF_FREEZE)
>> +                    refrigerator(PF_FREEZE);
>> +
>
>Perhaps you should also add.
>
>If the thread is needed for writing the image to storage, you should
>instead set the PF_NOFREEZE process flag when creating the thread.
>
You know for sleep into mem (s3) we also use
'freeze_processes/refrigerator', and the threads don't write image to
storage for S3. Should the threads be set the PF_NOFREEZE? Is there any
side effect for S3 if the threads are running?

Thanks,
Shaohua



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVGZQMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVGZQMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVGZQJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:09:17 -0400
Received: from fmr15.intel.com ([192.55.52.69]:23206 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261932AbVGZQIf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:08:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Variable ticks
Date: Tue, 26 Jul 2005 12:08:28 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424B27E@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Variable ticks
Thread-Index: AcWR+RzML27HiHcERyi9Uoz94GSfDQAAk92w
From: "Brown, Len" <len.brown@intel.com>
To: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2005 16:08:31.0960 (UTC) FILETIME=[44A86580:01C591FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>>>Trouble? Why would USB do DMA unless there was a device activity?
>> 
>> 
>> look here:
>> http://www.google.com/search?hl=en&q=usb+selective+suspend
>> 
>> Linux is working on it too, but it is in development.
>
>Somehow I didn't ask that right... The stuff on selective disable is 
>interesting, but my question is why a USB device, call it a keyboard, 
>would do DMA unless I press a key, at which point response will be 
>better if the CPU wakes up out of C3.
>
>I understand that specialty attachments may send what amounts to keep 
>alives, or gather data (webcam) you don't want, but the typical mouse 
>and KB would seem to be things which generate DMA at user initiation, 
>and would not be blocked for low power, only for suspend.

USB's hardware architecture was optimized for cost and ease of use,
it was not optimized for performance or power savings.

We need software disable because the USB hardware will keep
the memory bus busy constantly even if all the
actual USB devices are idle.  The power cost is that the CPU
is prevented from deep sleep so that it can snoop USB's
(idle) memory activity.

-Len

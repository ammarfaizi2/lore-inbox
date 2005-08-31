Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVHaWNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVHaWNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVHaWNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:13:10 -0400
Received: from fmr20.intel.com ([134.134.136.19]:30607 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964922AbVHaWNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:13:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Wed, 31 Aug 2005 15:11:40 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A042B0187@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
Thread-Index: AcWueFFtZfKo74WsQvCpCBmZok54cQAAClng
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Christopher Friesen" <cfriesen@nortel.com>, <joe.korty@ccur.com>
Cc: <akpm@osdl.org>, <george@mvista.com>, <johnstul@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Aug 2005 22:12:31.0253 (UTC) FILETIME=[14C30C50:01C5AE79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Christopher Friesen [mailto:cfriesen@nortel.com]
>Joe Korty wrote:
>
>> The returned timeout struct has a bit used to mark the value as
absolute.  Thus
>> the caller treats the returned timeout as a opaque cookie that can be
>> reapplied to the next (or more likely, the to-be restarted) timeout.
>
>Okay, endtime is always absolute value of when it should have expired.
>But I think I see a problem with the opaque cookie scheme and repeating
>timeouts.
>
>Suppose I want to wake my application at INTERVAL nanoseconds from now
>on the MONOTONIC clock, then again every INTERVAL nanoseconds after
that.

This API is not intended for your application to use directly, but
for kernel APIs that take sleeps from userspace (like
pthread_mutex_lock()
and friends), so this scenario is not very likely.

Granted, sleep() can be implemented with it too, so...

>How do I do that with this API?
>
>I can get the first sleep.  Suppose I oversleep by X nanoseconds.  I
>wake, and get an opaque timeout back.  How do I ask for the new wake
>time to be "endtime + INTERVAL"?

endtime.ts += INTERVAL

[we all know opaque is relative too] 
Or better, use itimers :)

-- Inaky

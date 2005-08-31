Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVHaXZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVHaXZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVHaXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:25:44 -0400
Received: from fmr17.intel.com ([134.134.136.16]:64143 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964972AbVHaXZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:25:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Wed, 31 Aug 2005 16:24:18 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
Thread-Index: AcWugBA7rOaff85SR8G1FhC8KGDBBwAAiN0g
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: <akpm@osdl.org>, <joe.korty@ccur.com>, <george@mvista.com>,
       <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Aug 2005 23:25:12.0288 (UTC) FILETIME=[3C242E00:01C5AE83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Roman Zippel [mailto:zippel@linux-m68k.org]
>On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:
>
>> Usefulness: (see the rationale in the patch), but in a nutshell;
>> most POSIX timeout specs have to be absolute in CLOCK_REALTIME
>> (eg: pthread_mutex_timed_lock()). Current kernel needs the timeout
>> relative, so glibc calls the kernel/however gets the time, computes
>> relative times and syscalls. Race conditions, overhead...etc.
>>
>> This mechanism supports both. That's why it is more general.
>
>Your patch basically only mentions fusyn, why does it need multiple
clock
>sources?

I cannot produce (top of my head) any other POSIX API calls that
allow you to specify another clock source, but they are there,
somewhere. If I am to introduce a new API, I better make it 
flexible enough so that other subsystems can use it for more stuff
other than...

>Why is not sufficient to just add a relative/absolute version,
>which convert the time at entry to kernel time?

...adding more versions that add complexity and duplicate
code in many different places (user-to-kernel copy, syscall entry 
points, timespec validation). And the minute you add a clock_id
you can steal some bits for specifying absolute/relative (or vice
versa), so it is almost a win-win situarion.

To summarize: thought about that, but it is fugly and not too practical.


Consider also his allows you to write extensions to POSIX or your
own user-level APIs that could allow (following the fusyn example) 
you to wait on a mutex with a timeout based off a monotonic clock, 
if you need it (or something that makes more sense than this--highres 
comes to mind). 

-- Inaky

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVHWBOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVHWBOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 21:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVHWBOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 21:14:24 -0400
Received: from fmr18.intel.com ([134.134.136.17]:43166 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751316AbVHWBOX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 21:14:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: [RFC] A more general timeout specification
Date: Mon, 22 Aug 2005 18:13:50 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0415D0AB@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [RFC] A more general timeout specification
thread-index: AcWnbMlnvqRU1LIaTniPJPDTQ54gTgAEAQDw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "john stultz" <johnstul@us.ibm.com>,
       "Inaky Perez-Gonzalez" <inaky@linux.intel.com>
Cc: "Nishanth Aravamudan" <nacc@us.ibm.com>, <joe.korty@ccur.com>,
       <george@mvista.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Aug 2005 01:13:52.0651 (UTC) FILETIME=[ECDCDDB0:01C5A77F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

>From: john stultz [mailto:johnstul@us.ibm.com]
>On Thu, 2005-07-28 at 18:52 -0700, Inaky Perez-Gonzalez wrote:
>> The main user of this new inteface is to allow system calls to get
>> time specified in an absolute form (as most of POSIX states) and thus
>> avoid extra time conversion work.
...
>>
http://groups-beta.google.com/groups?q=a+more+general+timeout+specificat
ion
...
>>
>> timeout_validate() error-checks the syntax of a timeout
>> argument and returns either zero or -EINVAL.  By breaking
>> timeout_validate() out from timeout_sleep(), it becomes possible
>> to error check the timeout 'far away' from the places in the
>> code where we would actually do the timeout, as well as being
>> able to perform such checks only at those places we know the
>> timeout specification is coming from an unsafe source.
>
>using gettimeofday() so that part looks good. I'm not completely sold
on
>why the validate interface is needed, but I didn't hear any objections
>from George, so I'd defer to those who deal more with those interfaces.

_validate() is mostly needed when we take a timeout specification from
user space (timeouts from kernel space are supposed to be ok). We need
to validate that the clock id passed is correct (existant), that
the 'struct timespec' is also legal (eg: nsec < 1000M), that the flags 
are ok (relative/absolute), etc...

The idea is that in your code that uses this, once you copy the 'struct 
timeout' from  user space you check it for validity. Then you can 
dive into any kind of code (atomic, sleep paths, whatever) without
having
to code an error path from deeep down for when the user passed a bad 
timeout.

It sure makes it more simple :)

-- Inaky

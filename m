Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVDKIul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVDKIul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDKIuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:50:40 -0400
Received: from fmr20.intel.com ([134.134.136.19]:4756 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261731AbVDKIud convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:50:33 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Mon, 11 Apr 2005 01:49:33 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02F64C65@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU+cm/A/19DSUJbQhmvKRZ0dBFU3gAABjhg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Joe Korty" <joe.korty@ccur.com>
X-OriginalArrivalTime: 11 Apr 2005 08:49:37.0241 (UTC) FILETIME=[6427AC90:01C53E73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Ingo Molnar [mailto:mingo@elte.hu]
>
>* Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
>
>> >OTOH, deadlock detection is another issue. It's quite expensive and
i'm
>> >not sure we want to make it a runtime thing. But for fusyn's
deadlock
>> >detection and safe teardown on owner-exit is a must-have i suspect?
>>
>> Not really. Deadlock check is needed on PI, so it can be done at the
>> same time (you have to walk the chain anyway). In any other case, it
>> is an option you can request (or not).
>
>well, i was talking about the mutex code in PREEMPT_RT. There deadlock
>detection is an optional debug feature. You dont _have_ to do deadlock
>detection for the kernel's locks, and there's a difference in
>performance.

Big mouth'o mine :-| 

Let me re-phrase then: it is a must have only on PI, to make sure 
you don't have a loop when doing it. Maybe is a consequence of the
algorithm I chose. -However- it should be possible to disable it
in cases where you are reasonably sure it won't happen (such as
kernel code). In any case, AFAIR, I still did not implement it.

Was this more useful?

-- Inaky 

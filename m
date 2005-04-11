Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVDKJES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVDKJES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVDKJER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:04:17 -0400
Received: from fmr19.intel.com ([134.134.136.18]:49635 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261741AbVDKJEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:04:13 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Mon, 11 Apr 2005 02:03:23 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02F64C6A@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU+dKG52I+1Ul+wTvWXCtxy4/jTmAAABdiA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Joe Korty" <joe.korty@ccur.com>
X-OriginalArrivalTime: 11 Apr 2005 09:03:26.0525 (UTC) FILETIME=[52725ED0:01C53E75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Ingo Molnar [mailto:mingo@elte.hu]
>
>* Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
>
>> Let me re-phrase then: it is a must have only on PI, to make sure you
>> don't have a loop when doing it. Maybe is a consequence of the
>> algorithm I chose. -However- it should be possible to disable it in
>> cases where you are reasonably sure it won't happen (such as kernel
>> code). In any case, AFAIR, I still did not implement it.
>
>are there cases where userspace wants to disable deadlock-detection for
>its own locks?

I would guess--if I know I have coded my application properly
(cough) or I am using locks that by design are completely orthogonal,
I would say deadlock checking is getting in the way.

>the deadlock detector in PREEMPT_RT is pretty much specialized for
>debugging (it does all sorts of weird locking tricks to get the first
>deadlock out, and to really report it on the console), but it ought to
>be possible to make it usable for userspace-controlled locks as well.

fusyn's is as simple as it can get: when you are about to lock(), it
checks that you don't own the lock already, but it generalizes it
(it checks that the owner of the lock is not waiting for a lock 
whose owner is waiting for a lock whose owner...is waiting for a lock
that you own).

-- Inaky

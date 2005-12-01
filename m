Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVLAF1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLAF1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVLAF1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:27:38 -0500
Received: from fmr18.intel.com ([134.134.136.17]:29930 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932083AbVLAF1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:27:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] Variable stopmachine_state should be volatile
Date: Thu, 1 Dec 2005 13:27:30 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84040B3E77@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Variable stopmachine_state should be volatile
Thread-Index: AcX2L/hRdNtQrwHXTmSdLDAuyFC7LwAB7FGQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>
X-OriginalArrivalTime: 01 Dec 2005 05:27:32.0289 (UTC) FILETIME=[EDC85310:01C5F637]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Pavel Machek [mailto:pavel@ucw.cz]
>>Sent: 2005Äê12ÔÂ1ÈÕ 11:26
>>To: Zhang, Yanmin
>>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Shah, Rajesh
>>Subject: Re: [BUG] Variable stopmachine_state should be volatile
>>
>>Hi!
>>
>>> >>Hi!
>>> >>
>>> >>> The model to access variable stopmachine_state is that a main thread
>>> >>> writes it and other threads read it. Its declaration has no sign
>>> >>> volatile. In the while loop in function stopmachine, this variable is
>>> >>> read, and compiler might optimize it by reading it once before the loop
>>> >>> and not reading it again in the loop, so the thread might enter dead
>>> >>> loop.
>>> >>
>>> >>No. volatile may look like a solution, but it usually is not. You may
>>> >>need some barriers, atomic_t or locking.
>>> >>								Pavel
>>> The original functions already use smp_mb/smp_wmb. My patch just
>>>tells compiler not to optimize by bringing the reading of
>>>stopmachine_state out of the while loop.
>>
>>Those barriers should already prevent compiler optimalization, no? If
>>they do not, just use some barriers that do.


I hit the problem when compiling 2.6 kernel by intel compiler.
How about to change the type of stopmachine_state to atomic_t?

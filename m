Return-Path: <linux-kernel-owner+w=401wt.eu-S1752010AbWLNXvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWLNXvo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWLNXvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:51:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:45810 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbWLNXvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:51:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,171,1165219200"; 
   d="scan'208"; a="174676836:sNHT33272302"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kref refcnt and false positives
Date: Thu, 14 Dec 2006 15:51:38 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454010572C1@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kref refcnt and false positives
Thread-Index: AccfVYqhGE0ngqJjSmmanwoF4T3whQAhOlGA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Greg KH" <gregkh@suse.de>, "Arjan" <arjan@linux.intel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
X-OriginalArrivalTime: 14 Dec 2006 23:51:39.0972 (UTC) FILETIME=[CCA00840:01C71FDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Eric Dumazet [mailto:dada1@cosmosbay.com] 
>Sent: Wednesday, December 13, 2006 11:57 PM
>To: Andrew Morton
>Cc: Greg KH; Pallipadi, Venkatesh; Arjan; linux-kernel; Eric 
>W. Biederman
>Subject: Re: kref refcnt and false positives
>
>
>I agree this 'optimization' is not "good" (I was the guy who 
>suggested it 
>http://lkml.org/lkml/2006/1/30/4 )
>
>After Eric Biederman message 
>(http://lkml.org/lkml/2006/1/30/292) I remember 
>adding some stat counters and telling Greg to not put the 
>patch in because 
>kref_put() was mostly called with refcount=1. But the patch 
>did its way. I 
>*did* ask Greg to revert it, but cannot find this mail 
>archived somewhere...
>
>But I believe Venkatesh problem comes from its release() 
>function : It is 
>supposed to free the object.
>If not, it should properly setup it so that further uses are OK.
>
>ie doing in release(kref)
>atomic_set(&kref->count, 0);
>

Agreed that setting kref refcnt to 0 in release will solve the probloem.
But, once the optimization code is removed, we don't need to set it to
zero as release will only be called after the count reaches zero anyway.

Thanks,
Venki

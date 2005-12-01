Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVLARS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVLARS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVLARS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:18:57 -0500
Received: from petasus.ims.intel.com ([62.118.80.130]:8859 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S932344AbVLARS4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:18:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/1] indirect function calls elimination in IO scheduler
Date: Thu, 1 Dec 2005 20:18:52 +0300
Message-ID: <6694B22B6436BC43B429958787E45498E78FA8@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: [PATCH 1/1] indirect function calls elimination in IO scheduler
Thread-Index: AcX2m0zwjdkBx3WSSBKPqIt2qs+fqg==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 01 Dec 2005 17:18:53.0158 (UTC) FILETIME=[4D901860:01C5F69B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,
 
You wrote about patch
>> This breaks reference counting of said
>> structure, so it's not really something that can be applied.
 
>> this patch is a no-go from the beginning since
>> you cannot ref count a statically embedded structure. It has to be
>> dynamically allocated.
 
My answer:
> There was no any 'ref count' elevator structure in 2.6.9. There was
not
> added any 'ref count' while modular and online switching was enabled.
 
>> The does exist outside of the queue getting gotten/put,
>> the switching being one of them. Tejun has patches for improving the
>> switching, so it would be possible to keep two schedulers alive for
the
>> queue for the duration of the switch.
 
Proposed patch does not modify "gotten/put" modules order.
elevator_attch() function dynamically fills 'kmalloced' memory by
elevator structure before patching.
This function  fills substructure after patching dynamically as well.
There is no reference count problem: we can return to old scheduler if
new one fails.
Both, old and new, schedulers are saved for the duration of the switch.
 
Leonid

 



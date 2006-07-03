Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWGCQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWGCQna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWGCQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:43:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:3342 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750913AbWGCQna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:43:30 -0400
X-IronPort-AV: i="4.06,201,1149490800"; 
   d="scan'208"; a="60007257:sNHT14341320"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Mon, 3 Jul 2006 20:43:22 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC053FD4@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: Acaev8wSo5wvAe8IQxGHODDj04XRTQ==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Jul 2006 16:43:27.0510 (UTC) FILETIME=[CEFA7360:01C69EBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Nikita Danilov writes:
> Wouldn't this interfere with current->backing_dev_info logic?

The proposed patch does not modify that logic.

> Maybe pdflush threads should set this field too?

If pdflush sets current->backing_dev_info it means to ignore congested
device state.
It will not help to get reclaimed memory for pdflush but will increase
congestion, and pdflush will be dependent from swapping out process
using congested queue. The queue may be just congested because of memory
for queue. Other page could be better candidate for memory reclamation.

So, pdflush should not set this field.

Leonid

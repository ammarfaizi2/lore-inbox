Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUDGQWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUDGQWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:22:10 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:38410 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263722AbUDGQWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:22:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss updates for 2.6.6xxx [1/2]
Date: Wed, 7 Apr 2004 11:21:47 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC200E@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.6.6xxx [1/2]
Thread-Index: AcQcu4X5AeyHmIP9R9S+RdjTnEmrogAAJSLw
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <alpm@odsl.org>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Apr 2004 16:21:48.0198 (UTC) FILETIME=[6D096C60:01C41CBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, you're right. I just regurgitated the same code. I'll pull my head out and try again :(

mikem

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Wednesday, April 07, 2004 11:15 AM
To: Miller, Mike (OS Dev)
Cc: alpm@odsl.org; axboe@suse.de; linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6.6xxx [1/2]


mikem@beardog.cca.cpqcorp.net wrote:
> This patch adds per logical device queues to the HP cciss driver. It currently only implements a single lock but when time permits I will provide that funtionality. Thanks to Jeff Garzik for providing some sample code.
> This patch built against 2.6.5. Please consider this for inclusion.


I appreciate the credit but I don't see that it addressed my original 
objection -- the starvation issue.

Do you cap the number of per-array requests a "1024 / n_arrays", or 
something like that?  You mentioned that the hardware has a maximum of 
1024 outstanding commands, for all devices.  The two typical solutions 
are a round-robin queue (see carmel.c) or limiting each array such that 
if all arrays are full of commands, the total outstanding never exceeds 
1024.

This patch may be OK for -mm, I would rather not see it go upstream -- 
it seems to me you are choosing to decrease stability to obtain a 
performance increase.  I think you can increase performance without 
decreasing stability.

	Jeff




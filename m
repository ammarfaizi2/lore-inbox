Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbUDGTLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbUDGTLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:11:55 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:48912 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264155AbUDGTLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:11:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss updates for 2.6.6xxx [1/2]
Date: Wed, 7 Apr 2004 14:11:39 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC2012@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.6.6xxx [1/2]
Thread-Index: AcQcviPYvhHWQTZ2Qpu32UBHWjansgAFZfHA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <alpm@odsl.org>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Apr 2004 19:11:40.0498 (UTC) FILETIME=[281EFB20:01C41CD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like the idea of capping max commands based on the number of arrays. One problem is that we can add or remove a logical drive during runtime. How would Linux handle us reshuffling the max commands for each queue?

mikem

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Wednesday, April 07, 2004 11:34 AM
To: Miller, Mike (OS Dev)
Cc: alpm@odsl.org; axboe@suse.de; linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6.6xxx [1/2]


Miller, Mike (OS Dev) wrote:
> Yep, you're right. I just regurgitated the same code. I'll pull my head out and try again :(


The easiest thing to do may be to take your patch #1, and then add code 
to clamp the per-queue outstanding-command (tag) depth to
	1024 / n_arrays_found

at initialization time.  Or perhaps s/n_arrays_found/max_arrays_per_hba/

I bet that's just a few additional lines of code, and should work...

Regards,

	Jeff




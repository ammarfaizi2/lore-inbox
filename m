Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUCIXhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUCIXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:37:47 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:57098 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262483AbUCIXfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:35:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: per device queues for cciss 2.6.0
Date: Tue, 9 Mar 2004 17:35:07 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC1EBA@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: per device queues for cciss 2.6.0
Thread-Index: AcQGJQ0pnjeDrd2xR42wsfjfbjazjwACYxGQ
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <axboe@suse.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Mar 2004 23:35:08.0871 (UTC) FILETIME=[28AA8570:01C4062F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The command buffer as it is now is per hba. We realize that there may be issues with volumes being starved out but the change was done to make the current driver work with multiple logical volumes. When we move to per logical volume locking scheme we can also implement a per logical volume command structure.

Thanks,
mikem

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Tuesday, March 09, 2004 4:22 PM
To: Miller, Mike (OS Dev)
Cc: axboe@suse.de; akpm@osdl.org; linux-kernel@vger.kernel.org
Subject: Re: per device queues for cciss 2.6.0


mikem@beardog.cca.cpqcorp.net wrote:
> This is resubmission of yesterdays patch. It adds support for per logical device queues in the cciss driver. I have clarified that we only use one lock for all queues and it is held as specified in ll_rw_block.c. The locking needs to be redone for maximum efficiency but schedules don't permit that work at this time. This was done to fix an Oops with multiple logical volumes on a controller.
> Please consider this patch for inclusion.


Is the hardware's command buffer per-device or per-HBA?

	Jeff




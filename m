Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVHIQj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVHIQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVHIQj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:39:56 -0400
Received: from emulex.emulex.com ([138.239.112.1]:22771 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S964873AbVHIQjz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:39:55 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: FW: [PATCH] shorten workqueue name length
Date: Tue, 9 Aug 2005 12:39:51 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F437F@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] shorten workqueue name length
Thread-Index: AcWc//bIWV9qtzH+RlaHsed5EZUDrgAAL9aA
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone give some history on why the workqueue name length is
limited to 10 characters ?  Can it be raised ? and if so to what limit ?

-- James S

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of Christoph Hellwig
Sent: Tuesday, August 09, 2005 12:32 PM
To: Smart, James
Cc: linux-scsi@vger.kernel.org
Subject: Re: [PATCH] shorten workqueue name length


On Tue, Aug 09, 2005 at 12:07:12PM -0400, James.Smart@Emulex.Com wrote:
> A customer passed this fix to me...
> 
> In a system with double-digit adapter counts, after a few
> rmmod/insmod attempts, the system oops. It always occurs when
> the scsi host number reaches 100.
> 
> What is happening is that scsi_add_host() detects a transport that
> needs to allocate a workqueue, thus calls create_singlethread_workqueue().
> It hits a BUG_ON() in kernel/workqueue.c:__create_workqueue() which
> ensures the length of the name for the workqueue is 10 characters or less.
> As the name is "scsi_wq_100", we have exceeded the 10 character max.
> 
> I assume there's good reason for the name to be 10 or less. So what I've
> done is shorten the name for the workqueue. Should work until the host number
> reaches 10000.

I'd suggest just killing that limit in workqueue.c

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVDUBQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDUBQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 21:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVDUBOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 21:14:11 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:1946 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261243AbVDUBMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 21:12:01 -0400
Subject: Re: Serious performance degradation on a RAID with kernel
	2.6.10-bk7 and later
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Andreas Hirstius <Andreas.Hirstius@cern.ch>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42668977.5060708@utah-nac.org>
References: <42669357.9080604@cern.ch>  <42668977.5060708@utah-nac.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 11:11:51 +1000
Message-Id: <1114045911.5182.2.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 10:55 -0600, jmerkey wrote:
> 
> For 3Ware, you need to chage the queue depths, and you will see 
> dramatically improved performance. 3Ware can take requests
> a lot faster than Linux pushes them out. Try changing this instead, you 
> won't be going to sleep all the time waiting on the read/write
> request queues to get "unstarved".
> 
> 
> /linux/include/linux/blkdev.h
> 
> //#define BLKDEV_MIN_RQ 4
> //#define BLKDEV_MAX_RQ 128 /* Default maximum */
> #define BLKDEV_MIN_RQ 4096
> #define BLKDEV_MAX_RQ 8192 /* Default maximum */
> 

BTW, don't do this. BLKDEV_MIN_RQ sets the size of the mempool
reserved requests and will only get slightly used in low memory
conditions, so most memory will probably be wasted.

Just change /sys/block/xxx/queue/nr_requests

Nick




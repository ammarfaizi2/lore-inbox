Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVA1ILf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVA1ILf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVA1ILS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:11:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28875 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261169AbVA1ILD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:11:03 -0500
Message-ID: <41F9F386.7070501@pobox.com>
Date: Fri, 28 Jan 2005 03:10:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
References: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com> <41F97299.2070909@pobox.com> <20050128065358.GA4800@suse.de>
In-Reply-To: <20050128065358.GA4800@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 27 2005, Jeff Garzik wrote:
> 
>>Doug Maxey wrote:
>>
>>>On Thu, 27 Jan 2005 13:02:48 +0100, Jens Axboe wrote:
>>>
>>>
>>>>Hi,
>>>>
>>>>For the longest time, only the old PATA drivers supported barrier writes
>>>>with journalled file systems. This patch adds support for the same type
>>>>of cache flushing barriers that PATA uses for SCSI, to be utilized with
>>>>libata. 
>>>
>>>
>>>What, if any mechanism supports changing the underlying write cache?  
>>>
>>>That is, assuming this is common across PATA and SCSI drives, and it is 
>>>possible to turn the cache off on the IDE drives, would switching the 
>>>cache underneath require completing the inflight IO?
>>
>>[ignoring your question, but it made me think...]
>>
>>
>>I am thinking the barrier support should know if the write cache is 
>>disabled (some datacenters do this), and avoid flushing if so?
> 
> 
> Ehm it does, read the code :)


I did.  I see nowhere that handles the case where the user uses a util 
(hdparm or blktool) to switch off write cache after sd.c has probed the 
disk.  sd only sets its WCE bit at probe time, and doesn't appear to 
notice state changes.

Since nobody snoops the MODE SELECT on the caching page, nobody knows 
past probe the state of write caching.

Thus my comment...   I think barrier support should know about that sort 
of thing :)

	Jeff



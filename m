Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWHNVEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWHNVEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWHNVEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:04:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4515 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752070AbWHNVEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:04:38 -0400
Message-ID: <44E0E55C.9010200@garzik.org>
Date: Mon, 14 Aug 2006 17:04:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Getting 'sync' to flush disk cache?
References: <44E0C373.6060008@garzik.org> <1155584098.2886.271.camel@laptopd505.fenrus.org> <20060814201545.GE16819@suse.de>
In-Reply-To: <20060814201545.GE16819@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 14 2006, Arjan van de Ven wrote:
>> On Mon, 2006-08-14 at 14:39 -0400, Jeff Garzik wrote:
>>> So...  has anybody given any thought to enabling fsync(2), fdatasync(2), 
>>> and sync_file_range(2) issuing a [FLUSH|SYNCHRONIZE] CACHE command?
>>>
>>> This has bugged me for _years_, that Linux does not do this.  Looking at 
>>> forums on the web, it bugs a lot of other people too.
>> eh afaik 2.6.17 and such do this if you have barriers enabled...
> 
> That is correct, but it only works on reiserfs and XFS and user space
> really cannot tell whether it did the right thing or not. File system
> developers really should take this more seriously...

IMO the non-journalling fs's should have some sort of common fsync 
helper via sync_inode(), sync_mapping_buffers(), and similar paths... 
Should be able get a bunch of fs's in one big swath that way.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUDNIm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263974AbUDNIm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:42:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263972AbUDNIm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:42:56 -0400
Message-ID: <407CF97F.7090903@pobox.com>
Date: Wed, 14 Apr 2004 04:42:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <407CEB91.1080503@pobox.com> <20040414082950.GD12558@suse.de>
In-Reply-To: <20040414082950.GD12558@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 14 2004, Jeff Garzik wrote:
>>===== fs/buffer.c 1.237 vs edited =====
>>--- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
>>+++ edited/fs/buffer.c	Wed Apr 14 03:39:15 2004
>>@@ -2688,6 +2688,7 @@
>> {
>> 	struct bio *bio;
>> 
>>+#ifdef BH_DEBUG
>> 	BUG_ON(!buffer_locked(bh));
>> 	BUG_ON(!buffer_mapped(bh));
>> 	BUG_ON(!bh->b_end_io);
> 
> 
> The last one will be 'caught' at the other end of io completion, so I
> guess that could be killed (even though you already lost the context of
> the error, then). The first two are buffer state errors, I think those
> should be kept unconditionally.
> 
> 
>>@@ -2698,6 +2699,7 @@
>> 		buffer_error();
>> 	if (rw == READ && buffer_dirty(bh))
>> 		buffer_error();
>>+#endif
> 
> 
> I'm fine with killing the buffer_error(), maybe
> 
> 	if (rw == WRITE && !buffer_uptodate(bh))
> 		buffer_error();
> 
> should be kept though.


Well, all of these are buffer state (and programmer) errors...

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUGMPCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUGMPCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUGMPCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:02:48 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:61346 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S265301AbUGMPCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:02:46 -0400
Message-ID: <40F3F993.6040602@metaparadigm.com>
Date: Tue, 13 Jul 2004 23:02:43 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lutz Vieweg <lkv@isg.de>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de> <40EFA4C8.1050409@metaparadigm.com> <40F2C882.7070406@isg.de> <40F36216.1080603@metaparadigm.com> <40F3DDC4.7060104@isg.de>
In-Reply-To: <40F3DDC4.7060104@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/04 21:04, Lutz Vieweg wrote:
>> You don't use mmap for speed but rather for convenience.
> 
> 
> But isn't an advantage with mmap() that there's no need for the kernel
> to copy what is to be written to a dedicated buffer? The kernel
> could initiate DMA writes directly from the working memory...

Yes, but page faults are expensive too. Each time a page is written
out it needs to be marked read only again and will cause a page fault
for the next write access from userspace. For certain workloads this
can easily add up to more than copy_(to|from)_user in read/write.

read/write also gives you more explicit control on IO batching and
scheduling (when to read or write). Less need for the kernel to employ
tricks to effectively coaslesce IOs on dirtied pages or sense
streaming access patterns.

~mc

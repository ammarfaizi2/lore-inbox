Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWHRRdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWHRRdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWHRRdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:33:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:26602 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751431AbWHRRdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:33:49 -0400
Message-ID: <44E5F9F0.6030805@us.ibm.com>
Date: Fri, 18 Aug 2006 10:33:36 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sho@tnes.nec.co.jp
CC: esandeen@redhat.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
References: <20060818181516sho@rifu.tnes.nec.co.jp>
In-Reply-To: <20060818181516sho@rifu.tnes.nec.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sho@tnes.nec.co.jp wrote:

> I have reviewed your patch and found other place which might
> cause overflow as below.  If group_first_block is the first block of
> the last group, overflow will occur.  This has already been fixed
> in my patch.
> 
> o ext3_try_to_allocate_with_rsv() in fs/ext3/balloc.c
> 	if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
> 		    || (my_rsv->rsv_end < group_first_block))
> 			BUG();
> 

Yes, this isn't being addressed in the current 2.6.18-rc4 kernel. I 
think this is better than casting to unsigned long long:

- 	if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
+ 	if ((my_rsv->rsv_start > group_first_block - 1 + 
EXT3_BLOCKS_PER_GROUP(sb))


Thanks,

Mingming

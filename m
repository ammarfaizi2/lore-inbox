Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWHRX5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWHRX5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWHRX5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:57:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751375AbWHRX5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:57:05 -0400
Message-ID: <44E653CA.1060502@redhat.com>
Date: Fri, 18 Aug 2006 18:56:58 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Eric Sandeen <esandeen@redhat.com>, Mingming Cao <cmm@us.ibm.com>,
       sho@tnes.nec.co.jp, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
References: <20060818181516sho@rifu.tnes.nec.co.jp> <44E5F9F0.6030805@us.ibm.com> <44E5FB5D.60403@redhat.com> <20060818231855.GW6634@schatzie.adilger.int>
In-Reply-To: <20060818231855.GW6634@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Aug 18, 2006  12:39 -0500, Eric Sandeen wrote:
>> @@ -168,7 +168,7 @@ goal_in_my_reservation(struct ext3_reser
>>  	ext3_fsblk_t group_first_block, group_last_block;
>>  
>>  	group_first_block = ext3_group_first_block_no(sb, group);
>> -	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
>> +	group_last_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
>>  
>>  	if ((rsv->_rsv_start > group_last_block) ||
>>  	    (rsv->_rsv_end < group_first_block))
>> @@ -897,7 +897,7 @@ static int alloc_new_reservation(struct 
>>  	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
>>  
>>  	group_first_block = ext3_group_first_block_no(sb, group);
>> -	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
>> +	group_end_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
>>  
>>  	if (grp_goal < 0)
>>  		start_block = group_first_block;
> 
> I don't see how these can make a difference?  Surely, if the intermediate
> sum overflows it will then underflow when "- 1" is done?  Not that I mind,
> per-se, just curious why you think this fixes anything.

Well, you're right, if it overflows then it will underflow again.  And I've not 
observed any actual failures, and I don't expect to.  But personally I guess I'd 
rather avoid the whole overflow in the first place... maybe I'm being silly.  :)

If you think it's unnecessary code churn then we can not make this change...

-Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWHRXTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWHRXTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWHRXTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:19:04 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:31971 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751049AbWHRXTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:19:00 -0400
Date: Fri, 18 Aug 2006 17:18:55 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Eric Sandeen <esandeen@redhat.com>
Cc: Mingming Cao <cmm@us.ibm.com>, sho@tnes.nec.co.jp,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
Message-ID: <20060818231855.GW6634@schatzie.adilger.int>
Mail-Followup-To: Eric Sandeen <esandeen@redhat.com>,
	Mingming Cao <cmm@us.ibm.com>, sho@tnes.nec.co.jp,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060818181516sho@rifu.tnes.nec.co.jp> <44E5F9F0.6030805@us.ibm.com> <44E5FB5D.60403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E5FB5D.60403@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2006  12:39 -0500, Eric Sandeen wrote:
> @@ -168,7 +168,7 @@ goal_in_my_reservation(struct ext3_reser
>  	ext3_fsblk_t group_first_block, group_last_block;
>  
>  	group_first_block = ext3_group_first_block_no(sb, group);
> -	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
> +	group_last_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
>  
>  	if ((rsv->_rsv_start > group_last_block) ||
>  	    (rsv->_rsv_end < group_first_block))
> @@ -897,7 +897,7 @@ static int alloc_new_reservation(struct 
>  	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
>  
>  	group_first_block = ext3_group_first_block_no(sb, group);
> -	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
> +	group_end_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
>  
>  	if (grp_goal < 0)
>  		start_block = group_first_block;

I don't see how these can make a difference?  Surely, if the intermediate
sum overflows it will then underflow when "- 1" is done?  Not that I mind,
per-se, just curious why you think this fixes anything.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


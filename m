Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWHPLpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWHPLpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWHPLpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:45:41 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:7338 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751114AbWHPLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:45:40 -0400
Date: Wed, 16 Aug 2006 13:45:46 +0200
From: Johann Lombardi <johann.lombardi@bull.net>
To: Eric Sandeen <esandeen@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
Message-ID: <20060816114546.GE2698@chiva>
References: <44DD00FA.5060600@redhat.com>
MIME-Version: 1.0
In-Reply-To: <44DD00FA.5060600@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/08/2006 13:50:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/08/2006 13:50:44,
	Serialize complete at 16/08/2006 13:50:44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static int ext3_check_descriptors (struct super_block * sb)
>  {
>  	struct ext3_sb_info *sbi = EXT3_SB(sb);
> -	ext3_fsblk_t block = le32_to_cpu(sbi->s_es->s_first_data_block);
> +	ext3_fsblk_t first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
> +	ext3_fsblk_t last_block;
>  	struct ext3_group_desc * gdp = NULL;
>  	int desc_block = 0;
>  	int i;
> @@ -1141,12 +1142,16 @@ static int ext3_check_descriptors (struc
>  
>  	for (i = 0; i < sbi->s_groups_count; i++)
>  	{
> +		if (i == sbi->s_groups_count - 1)
> +			last_block = sb->s_blocks_count - 1;
> +		else
> +			last = first + (EXT3_BLOCKS_PER_GROUP(sb) - 1);

I think it should be:
last_block = first_block + ...

Johann

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbVD3ApM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbVD3ApM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVD3ApL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:45:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20352 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263094AbVD3Ao3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:44:29 -0400
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20050429135211.GA4539@in.ibm.com>
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <20050429135211.GA4539@in.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 29 Apr 2005 17:44:26 -0700
Message-Id: <1114821866.7635.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, sorry about the empty message ...

> -static int ext3_writepages_get_block(struct inode *inode, sector_t iblock,
> -			struct buffer_head *bh, int create)
> +static int ext3_writepages_get_blocks(struct inode *inode, sector_t iblock,
> +		unsigned long max_blocks, struct buffer_head *bh, int create)
>  {
> -	return ext3_direct_io_get_blocks(inode, iblock, 1, bh, create);
> +	return ext3_direct_io_get_blocks(inode, iblock, max_blocks, bh, create);
>  }
>  

I have a question here, ext3_direct_io_get_blocks use DIO_CREDITS
(EXT3_RESERVE_TRANS_BLOCKS + 32 = ) to reserve the space for
journalling, but it seems based on assumption of one data block update
once a time. Is it sufficent to re-use that routine for multiple block
allocation here? Don't we need something like
ext3_writepage_trans_blocks() here?

Thanks,
Mingming


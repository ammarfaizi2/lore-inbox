Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVD3Qyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVD3Qyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVD3Qyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:54:35 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31403 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261294AbVD3QyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:54:17 -0400
Date: Sat, 30 Apr 2005 22:33:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-ID: <20050430170331.GE3941@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk> <1113288087.4319.49.camel@localhost.localdomain> <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk> <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com> <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <20050429135211.GA4539@in.ibm.com> <1114821866.7635.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114821866.7635.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 05:44:26PM -0700, Mingming Cao wrote:
> Oops, sorry about the empty message ...
> 
> > -static int ext3_writepages_get_block(struct inode *inode, sector_t iblock,
> > -			struct buffer_head *bh, int create)
> > +static int ext3_writepages_get_blocks(struct inode *inode, sector_t iblock,
> > +		unsigned long max_blocks, struct buffer_head *bh, int create)
> >  {
> > -	return ext3_direct_io_get_blocks(inode, iblock, 1, bh, create);
> > +	return ext3_direct_io_get_blocks(inode, iblock, max_blocks, bh, create);
> >  }
> >  
> 
> I have a question here, ext3_direct_io_get_blocks use DIO_CREDITS
> (EXT3_RESERVE_TRANS_BLOCKS + 32 = ) to reserve the space for
> journalling, but it seems based on assumption of one data block update
> once a time. Is it sufficent to re-use that routine for multiple block
> allocation here? Don't we need something like
> ext3_writepage_trans_blocks() here?

Quite likely - with your patch, as get_blocks actually allocates
multiple blocks at a time, the min credits estimate would 
change for ext3_direct_io_get_blocks/ext3_writepages_get_blocks.

Regards
Suparna

> 
> Thanks,
> Mingming
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


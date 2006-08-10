Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWHJGlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWHJGlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWHJGk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:40:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161093AbWHJGk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:40:58 -0400
Date: Wed, 9 Aug 2006 23:40:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] 48bit support in extents
Message-Id: <20060809234054.f9365c4b.akpm@osdl.org>
In-Reply-To: <1155172873.3161.83.camel@localhost.localdomain>
References: <1155172873.3161.83.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:21:13 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> +/* this macro combines low and hi parts of phys. blocknr into ext4_fsblk_t */

This isn't a macro.

> +static inline ext4_fsblk_t ext_pblock(struct ext4_extent *ex)
> +{
> +	ext4_fsblk_t block;
> +
> +	block = le32_to_cpu(ex->ee_start);
> +	if (sizeof(ext4_fsblk_t) > 4)
> +		block |= ((ext4_fsblk_t) le16_to_cpu(ex->ee_start_hi) << 31) << 1;
> +	return block;
> +}

Oh.  I see the other patch did

	typedef sector_t ext4_fs_block_t;

(except someone misspelled "block" as "blk" ;))

Do we really want to do this?  I guess there's some value, for people with
32-bit machines who want extents and who are too mean to use a 64-bit
sector_t.  But gee that's marginal.  And it introduces interesting
compatibility questions and significantly adds to the testing burden.

I think that requiring 64-bit sector_t is reasonable?

Then again, I see from the other patches that considerable thought and
effort has gone into sustaining this turkey, so I guess I'm missing
something again.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQKHWv5>; Wed, 8 Nov 2000 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKHWvr>; Wed, 8 Nov 2000 17:51:47 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:38661 "EHLO
	d185d0f1c.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129211AbQKHWvb>; Wed, 8 Nov 2000 17:51:31 -0500
Date: Wed, 08 Nov 2000 17:50:40 -0500
From: Chris Mason <mason@suse.com>
To: Tigran Aivazian <tigran@veritas.com>, Hans Reiser <hans@reiser.to>
cc: linux-kernel@vger.kernel.org
Subject: Re: panic in reiserfs: _get_block_create_0 gets bh_result->b_data = NULL
Message-ID: <202710000.973723840@coffee>
In-Reply-To: <Pine.LNX.4.21.0011031556120.1019-100000@saturn.homenet>
X-Mailer: Mulberry/2.0.6a8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, November 03, 2000 15:56:36 +0000 Tigran Aivazian <tigran@veritas.com> wrote:

> On Fri, 3 Nov 2000, Tigran Aivazian wrote:
> 
>> Hi Hans,
>> 
>> Simply starting the validation phase of SPEC SFS with NFS mounted reiserfs
>> filesystem panics as shown in the log below. A quick look at the source
>> suggests that _get_block_create_0() (and therefore, more generally,
>> reiserfs_get_block()) was passed a buffer head bh_result with ->b_data =
>> NULL. So, we panic at line 256 of fs/reiserfs/inode.c when doing:
>> 
>> memset (bh_result->b_data, 0, inode->i_sb->s_blocksize)
>> 
> 

Ok, I've tracked these down to a few places in our tail handling code.  Working on the fixes now. 

-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

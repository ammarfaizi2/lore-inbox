Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265915AbSKBJz7>; Sat, 2 Nov 2002 04:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265916AbSKBJz7>; Sat, 2 Nov 2002 04:55:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:49323 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265915AbSKBJz6>;
	Sat, 2 Nov 2002 04:55:58 -0500
Message-ID: <3DC3A2AD.69775F06@digeo.com>
Date: Sat, 02 Nov 2002 02:02:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Dave Jones <davej@codemonkey.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net> <20021102000907.GA9229@suse.de> <3DC3207A.450402B3@zip.com.au> <3DC38C43.6020103@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 10:02:21.0935 (UTC) FILETIME=[EFA7DFF0:01C28256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> ...
> That said, I would like to again point out that using sparse swapfiles
> should still be discouraged.  It may be supported, but it's much better
> for system performance and stability, IMO, if the sysadmin makes certain
> all swapfiles are 100% allocated before they are mentioned to the swap
> subsystem.
> 

That got stamped out.  swapon will fail if the file isn't fully
instantiated on disk:


static int setup_swap_extents(struct swap_info_struct *sis)
{
	...
                        block = bmap(inode, probe_block + block_in_page);
                        if (block == 0)
                                goto bad_bmap;
	...

bad_bmap:
        printk(KERN_ERR "swapon: swapfile has holes\n");
        ret = -EINVAL;
}

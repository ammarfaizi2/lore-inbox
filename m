Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267631AbRGNL5j>; Sat, 14 Jul 2001 07:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbRGNL5a>; Sat, 14 Jul 2001 07:57:30 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:18057 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267631AbRGNL5W>; Sat, 14 Jul 2001 07:57:22 -0400
Message-ID: <3B5033F2.AF71624E@uow.edu.au>
Date: Sat, 14 Jul 2001 21:58:42 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com> <3B4F0273.1DF40F8E@uow.edu.au> <125101c10bc1$85eab630$e1de11cc@csihq.com> <20010713183800.J13419@redhat.com> <001101c10c51$bd6239e0$b6562341@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> Ummm...that would be the version(s) mentioned in the subject line???? :-)

doh.

OK, there was a nasty bug in 0.9.1 which I was not able to trigger
in a solid month's testing.  But others with more worthy hardware
were able to find it quite quickly.  Stephen fixed it in 0.9.2.
I don't know if it explains the failure you saw.  This:

	EXT3-fs error (device md(9,0)): ext3_new_inode: reserved
	inode or inode > inodes count - block_group = 0,inode=1

is nasty.  The LRU cache of inode bitmaps got wrecked.  Ugly.

Maybe one more try?

> My .config has
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> I've got 2G of RAM
> 
> And the main thing I noticed was kswapd going nuts -- this was NOT observed
> with the same tiobench on ext2 (same filesystem).  The performance with ext3
> reduced by about 66% on two threads -- and I think that is due to kswapd
> hogging CPU time.

Yup.  I've nailed this one - it's lovely.

I'll be back.

-

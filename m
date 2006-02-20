Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWBTRP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWBTRP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWBTRP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:15:57 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:34435
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1161052AbWBTRP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:15:56 -0500
Date: Mon, 20 Feb 2006 12:11:20 -0500
From: Sonny Rao <sonny@burdell.org>
To: Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Vitaly Fertman <vetalf@inbox.ru>
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060220171120.GA24542@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com, Vitaly Fertman <vetalf@inbox.ru>
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr> <20060220082946.A9478997@wobbly.melbourne.sgi.com> <20060219215209.GB7974@redhat.com> <20060220070916.GA8101@kevlar.burdell.org> <43F96DE9.7070209@namesys.com> <20060220164120.GA24077@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220164120.GA24077@kevlar.burdell.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 11:41:20AM -0500, Sonny Rao wrote:
> (trimmed the cc list a bit since this is all Reiserfs specific)
> 
> On Sun, Feb 19, 2006 at 11:21:13PM -0800, Hans Reiser wrote:
> > Thanks kindly Sonny, Chris is this bug known/fixed?
> 
> Hi, I'm still seeing the issue on 2.6.16-rc4 so I don't think it's
> fixed yet. 
> 
> Here's some output :
> 
> Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: found reiserfs format "3.6" with standard journal
> Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: using ordered data mode
> Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: journal params: device loop0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> Feb 20 10:36:25 localhost kernel: ReiserFS: loop0: checking transaction log (loop0)
> Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
> Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
> Feb 20 10:36:27 localhost kernel: device blocksize: 4096
> Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
> Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
> Feb 20 10:36:27 localhost kernel: device blocksize: 4096
> Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
> Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
> Feb 20 10:36:27 localhost kernel: device blocksize: 4096
> Feb 20 10:36:27 localhost kernel: __find_get_block_slow() failed. block=18446744072887476243, b_blocknr=3472891923
> Feb 20 10:36:27 localhost kernel: b_state=0x00000020, b_size=4096
> Feb 20 10:36:27 localhost kernel: device blocksize: 4096
> ...
> ad infinitum
> 
> I'll try and add a dump_stack() to the code that prints this stuff later today

Ok, didn't take as long as I thought :)

Feb 20 11:03:57 localhost kernel: device blocksize: 4096
Feb 20 11:03:57 localhost kernel:  [<b01042dd>] show_trace+0xd/0x10
Feb 20 11:03:57 localhost kernel:  [<b01042f7>] dump_stack+0x17/0x20
Feb 20 11:03:57 localhost kernel:  [<b0166973>] __find_get_block_slow+0x143/0x180
Feb 20 11:03:57 localhost kernel:  [<b0168b72>] __find_get_block+0xf2/0x210
Feb 20 11:03:57 localhost kernel:  [<b0168e59>] __getblk+0x1c9/0x280
Feb 20 11:03:57 localhost kernel:  [<f1209125>] search_by_key+0xb5/0x1330 [reiserfs]
Feb 20 11:03:57 localhost kernel:  [<f11f4130>] reiserfs_read_locked_inode+0x60/0x5e0 [reiserfs]
Feb 20 11:03:57 localhost kernel:  [<f120207c>] reiserfs_fill_super+0xfec/0x1430 [reiserfs]
Feb 20 11:03:57 localhost kernel:  [<b016b8f9>] get_sb_bdev+0xd9/0x107
Feb 20 11:03:57 localhost kernel:  [<f11ff0eb>] get_super_block+0x1b/0x30 [reiserfs]
Feb 20 11:03:57 localhost kernel:  [<b016ad1b>] do_kern_mount+0xbb/0x160
Feb 20 11:03:57 localhost kernel:  [<b0182fcd>] do_mount+0x2bd/0x6f0
Feb 20 11:03:57 localhost kernel:  [<b018346f>] sys_mount+0x6f/0xb0
Feb 20 11:03:57 localhost kernel:  [<b0102f97>] sysenter_past_esp+0x54/0x75

So, search_by_key isn't terminating.

Also, fwiw I don't see this bug on ppc64, I get this message instead:

ReiserFS: loop0: found reiserfs format "3.6" with standard journal
ReiserFS: loop0: using ordered data mode
ReiserFS: loop0: journal params: device loop0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: loop0: checking transaction log (loop0)
attempt to access beyond end of device
loop0: rw=0, want=18446744067132948640, limit=70000
ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [1 2 0x0 SD]

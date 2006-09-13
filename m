Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWIMB7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWIMB7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWIMB7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:59:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11399 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751489AbWIMB73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:59:29 -0400
Date: Wed, 13 Sep 2006 11:58:50 +1000
From: David Chinner <dgc@sgi.com>
To: xfs-masters@oss.sgi.com
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Message-ID: <20060913015850.GB3034@melbourne.sgi.com>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com> <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com> <20060912162555.d71af631.akpm@osdl.org> <6bffcb0e0609121634l7db1808cwa33601a6628ee7eb@mail.gmail.com> <20060912163749.27c1e0db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912163749.27c1e0db.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 04:37:49PM -0700, Andrew Morton wrote:
> On Wed, 13 Sep 2006 01:34:34 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
> > On 13/09/06, Andrew Morton <akpm@osdl.org> wrote:
> > > On Tue, 12 Sep 2006 17:42:10 +0200
> > > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> > >
> > > > On 12/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > > > On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> > > > > >
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> > > > > >
> > > > >
> > > > > I get this while umounting jfs (umount segfaulted).
> > > >
> > > > s/jfs/xfs
> > >
> > > Do you mean that both JFS and XFS exhibit this bug, or only XFS?
> > 
> > Only XFS. (s/jfs/xfs - "Thinking in s/c++/sed :)")
> 
> OK, thanks.  Let us rub the xfs-masters lamp and see what emerges.

Just for XFs list folks:


http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-config1
http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg1

Call Trace:
[<c013ae74>] lock_release_non_nested+0xd8/0x143
[<c013b291>] lock_release+0x178/0x19f
[<c02f7dc5>] __mutex_unlock_slowpath+0xbb/0x131
[<c02f7e43>] mutex_unlock+0x8/0xa
[<c017655f>] generic_shutdown_super+0x9c/0xd9
[<c01765bc>] kill_block_super+0x20/0x32
[<c017667c>] deactivate_super+0x5d/0x6f
[<c01892bc>] mntput_no_expire+0x52/0x85
[<c017b2c9>] path_release_on_umount+0x15/0x18
[<c018a469>] sys_umount+0x1e1/0x215
[<c018a4aa>] sys_oldumount+0xd/0xf
[<c0103156>] sysenter_past_esp+0x5f/0x99

I'm not sure why XFS would cause this - the crash is outside XFS releasing
a mutex (sb->s_lock) that XFS code has never touched. I doubt anyone
in the XFS team has done any testing on this -mm kernel...

What is the test case, Michal? Can you post the script you used?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

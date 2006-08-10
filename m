Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWHJXRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHJXRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWHJXRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:17:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58778 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932213AbWHJXRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:17:23 -0400
Date: Fri, 11 Aug 2006 09:16:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4+ext4 oops while mounting xfs
Message-ID: <20060811091659.E2596458@wobbly.melbourne.sgi.com>
References: <6bffcb0e0608100805k42357f5bxa73189c38fb926df@mail.gmail.com> <6bffcb0e0608101608j4fc41945of65173793703a065@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6bffcb0e0608101608j4fc41945of65173793703a065@mail.gmail.com>; from michal.k.k.piotrowski@gmail.com on Fri, Aug 11, 2006 at 01:08:44AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 01:08:44AM +0200, Michal Piotrowski wrote:
> On 10/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > ...
> > Aug 10 16:50:53 ltg01-fedora kernel: EFLAGS: 00010002   (2.6.18-rc4 #119)
> > Aug 10 16:50:53 ltg01-fedora kernel: EIP is at __lock_acquire+0x2ca/0x9b6
> > Aug 10 16:50:53 ltg01-fedora kernel: Call Trace:
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c0135ccb>]
> > lock_release_non_nested+0xc5/0x11d
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c0136026>] lock_release+0x12f/0x159
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d579e>]
> > __mutex_unlock_slowpath+0x99/0xff
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c02d580c>] mutex_unlock+0x8/0xa
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d3b2>]
> > generic_shutdown_super+0xbb/0x113
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d42a>] kill_block_super+0x20/0x32
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c016d4ea>] deactivate_super+0x5d/0x6f
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c0180336>] mntput_no_expire+0x42/0x72
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c0173147>]
> > path_release_on_umount+0x15/0x18
> > Aug 10 16:50:53 ltg01-fedora kernel:  [<c018147c>] sys_umount+0x1e7/0x21b
> ...
> It's fixed in latest 2.6.18-rc4-git*.

We've not changed anything mount related in current git* kernels,
are you sure its fixed (did it happen every time)?  I'm not sure
how its XFS related too ... looks possibly lockdep related (from
*non_nested back there?) and perhaps an issue with sb->s_lock in
the kill_block_super unlock_super call?

cheers.

-- 
Nathan

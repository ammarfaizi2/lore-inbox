Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760187AbWLDBfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760187AbWLDBfj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760199AbWLDBfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:35:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:187 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1760187AbWLDBfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:35:38 -0500
Date: Mon, 4 Dec 2006 12:35:20 +1100
From: David Chinner <dgc@sgi.com>
To: Stephen Pollei <stephen.pollei@gmail.com>
Cc: Mike Mattie <codermattie@gmail.com>,
       "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: "BUG: held lock freed!" lock validator tripped by kswapd & xfs
Message-ID: <20061204013520.GI44411608@melbourne.sgi.com>
References: <20061201095349.2a92c997@reforged> <feed8cdd0612011434n4c025fcbvd9997485d8b35149@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feed8cdd0612011434n4c025fcbvd9997485d8b35149@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 02:34:42PM -0800, Stephen Pollei wrote:
> On 12/1/06, Mike Mattie <codermattie@gmail.com> wrote:
> 
> >In an attempt to debug another kernel issue I turned on the lock validator 
> >and
> >managed to generate this report.
> >
> >As a side note the first attempt to boot with the lock validator failed 
> >with
> >a message indicating I had exceeded MAX_LOCK_DEPTH. To get this trace
> >I patched sched.h: MAX_LOCK_DEPTH to 60.
> >
> >Dec  1 08:35:41 reforged [ 3052.513931] =========================
> >Dec  1 08:35:41 reforged [ 3052.513937] [ BUG: held lock freed! ]
> >Dec  1 08:35:41 reforged [ 3052.513939] -------------------------
> >Dec  1 08:35:41 reforged [ 3052.513943] kswapd0/183 is freeing memory
> >c3458000-c3458fff, with a lock still held there! Dec  1 08:35:41
> >reforged [ 3052.513947]  (&(&ip->i_iolock)->mr_lock){....}, at:
> >[<c0222289>] xfs_ilock+0x20/0x75 Dec  1 08:35:41 reforged
> >[ 3052.513959] 28 locks held by kswapd0/183: Dec  1 08:35:41 reforged
> >[ 3052.513961]  #0:  (&(&ip->i_iolock)->mr_lock){....}, at:
> >[<c0222289>] xfs_ilock+0x20/0x75 Dec  1 08:35:41 reforged
> >[ 3052.513968]  #1:  (&(&ip->i_lock)->mr_lock){....}, at: [<c02222bb>]
> >xfs_ilock+0x52/0x75 Dec  1 08:35:41 reforged [ 3052.513975]
> 
> seems to alternate between same two locks. But both c0222289 and
> c02222bb are not between the page(oxfff=4095 or about 4k) which kswapd
> is trying to get rid of.
> I think this trace is on crack somehow.

IIRC, lockdep doesn't understand the xfs inode locks yet. We've
got a patch to fix most of this, but I don't think it's been merged.

Cheers,

Dave
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVAKBcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVAKBcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVAKB1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:27:17 -0500
Received: from holomorphy.com ([207.189.100.168]:46033 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262644AbVAKBXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:23:22 -0500
Date: Mon, 10 Jan 2005 17:23:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patch] Per-sb s_all_inodes list
Message-ID: <20050111012311.GD2696@holomorphy.com>
References: <41E2F15C.3010607@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2F15C.3010607@sun.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 04:19:24PM -0500, Mike Waychison wrote:
> Releasing a super_block requires walking all inodes for the given
> superblock and releasing them. Currently, inodes are found on one of
> four lists:
[...]
> The second list, inode_unused can potentially be quite large.
> Unfortunately, it cannot be made per-sb as it is the global LRU list
> used for inode cache reduction under memory pressure.
> When unmounting a single filesystem, profiling shows dramatic time spent
> walking inode_unused.  This because very noticeble when one is
> unmounting a decently sized tree of filesystems.
> The proposed solution is to create a new list per-sb, that contains all
> inodes allocated.  It is maintained under the inode_lock for the sake of
> simplicity, but this may prove unneccesary, and may be better done with
> another global or per-sb lock.

I thought this was a good idea a number of months ago myself when I saw
a patch for 2.4.x implementing this from Kirill Korotaev, so I ported
that code to 2.6.x and it got merged in -mm then. That patch was merged
into Linus' bk shortly after 2.6.10. Could you check Linus' bk to see
if what made it there resolves the issue as well as your own?

-- wli

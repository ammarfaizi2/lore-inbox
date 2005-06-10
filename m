Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVFJB7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVFJB7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 21:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVFJB72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 21:59:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28612 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262196AbVFJB7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 21:59:23 -0400
Date: Fri, 10 Jun 2005 11:52:41 +1000
From: Nathan Scott <nathans@sgi.com>
To: Marek Materzok <tilk@lucifer.czad.org>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: XFS oops, kernel 2.4.30 w/grsecurity
Message-ID: <20050610015241.GF791@frodo>
References: <1118062022.6266.19.camel@lucifer.czad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118062022.6266.19.camel@lucifer.czad.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 02:47:02PM +0200, Marek Materzok wrote:
> Jun  6 11:40:08 lucifer kernel: Filesystem "ide0(3,6)": XFS internal error xfs_btree_check_lblock at line 222 of file xfs_btree.c.  Caller 0xc01ed58d
> Jun  6 11:40:08 lucifer kernel: c9871750 c01efc41 c0374857 00000001 d71ffc00 c037484b 000000de c01ed58d 
> Jun  6 11:40:08 lucifer kernel:        c8bd4f80 d76b2940 00ca1740 00000000 00000008 00000000 c987178c cf416124 
> ...
> Then, the /home partition (/dev/hda6) was disabled, and every access to
> it ended with EIO. A reboot fixed the problem - the filesystem was
> rebuilt and mounted correctly. Nothing like this happened ever to my XFS
> filesystems.

This isn't an oops, its what XFS does when it detects on-disk
metadata corruption - it shuts down the filesystem, reports a
kernel stack trace and some other diagnostics, and returns EIO
on subsequent accesses to the filesystem until the problem is
resolved and the filesystem is mounted once more.

cheers.

-- 
Nathan

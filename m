Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265158AbUE0UGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbUE0UGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUE0UGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:06:51 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:61590 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265178AbUE0UGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:06:37 -0400
Date: Fri, 28 May 2004 06:06:25 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Johnson <dj@david-web.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Message-ID: <20040528060625.A860438@wobbly.melbourne.sgi.com>
References: <200405271736.08288.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405271736.08288.dj@david-web.co.uk>; from dj@david-web.co.uk on Thu, May 27, 2004 at 05:36:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 05:36:08PM +0100, David Johnson wrote:
> Hello,
> 
> I'm having a problem getting my system to boot with 2.6.6 and a XFS root 
> filesystem. On boot it can't mount the root fs:
> 
> XFS: Bad magic number
> XFS: SB validate failed

This is XFS saying "I read the first sector ondisk, and it
doesn't have the XFS superblock magic number in the first
word".  This is the very first IO request XFS issues on mount.
The read has completed without an error, its the contents of
the buffer we get back that isn't an XFS superblock.

So, not a XFS compiled-in/module issue as was suggested, and
not an XFS issue at all - looks like there's some problem in
getting the root device identifier into the kernel I'd guess.

> Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)

The "unknown" & (0,0) there is probably a hint, I've never come
across that before though.

cheers.

-- 
Nathan

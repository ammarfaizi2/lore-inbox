Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVCDHRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVCDHRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVCDHRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:17:50 -0500
Received: from waste.org ([216.27.176.166]:3721 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262590AbVCDHQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:16:44 -0500
Date: Thu, 3 Mar 2005 23:16:13 -0800
From: Matt Mackall <mpm@selenic.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiser@namesys.com,
       mc@cs.Stanford.EDU
Subject: Re: [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync option?
Message-ID: <20050304071613.GQ3163@waste.org>
References: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 10:33:40PM -0800, Junfeng Yang wrote:
> 
> Hi,
> 
> FiSC (our file system checker) emits several warnings on ext2, jfs and
> reiserfs, complaining that diretories or files are lost while FiSC
> believes they should already be persistent on disk. (ext3 behaves
> correctly.)
> 
> All warnings boil down to a single cause:  when these file systems are
> mounted -o sync or dirsync, dirty blocks are still written out
> asynchronously.  It appears to me that these mount options don't have any
> effect on these file systems.  Is this the intended behavior?

I don't believe so. The sync option should definitionally make calls
to fsync for integrity redundant. This probably got broken ages ago
for ext2 in one of the many buffer/page cache refactorings.

-- 
Mathematics is the supreme nostalgia of our time.

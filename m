Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135946AbRDZVtB>; Thu, 26 Apr 2001 17:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135947AbRDZVsw>; Thu, 26 Apr 2001 17:48:52 -0400
Received: from [63.231.122.81] ([63.231.122.81]:18239 "EHLO lynx.turbolabs.com")
	by vger.kernel.org with ESMTP id <S135946AbRDZVsi>;
	Thu, 26 Apr 2001 17:48:38 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104251839.MAA30241@lynx.turbolabs.com>
Subject: Re: hundreds of mount --bind mountpoints?
To: viro@math.psu.edu (Alexander Viro)
Date: Wed, 25 Apr 2001 12:39:03 -0600 (MDT)
Cc: adilger@turbolinux.com (Andreas Dilger), tomlins@cam.org (Ed Tomlinson),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0104240534440.6992-100000@weyl.math.psu.edu> from "Alexander Viro" at Apr 24, 2001 06:01:12 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> It's not a fscking rocket science - encapsulate accesses to ->u.foofs_i
> into inlined function, find ->read_inode, find places that do get_empty_inode

OK, I was doing this for the ext3 port I'm working on for 2.4, and ran into
a snag.  In the ext3_inode_info, there is a list_head.  However, if this is
moved into a separate slab struct, it is now impossible to locate the inode
from the offset in the slab struct.  When I was checking the size of each
inode_info struct, I noticed several others that had list_heads in them.
One solution is that we store list_heads in the inode proper, after generic_ip.

Cheers, Andreas
-- 
Andreas Dilger                               TurboLabs filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

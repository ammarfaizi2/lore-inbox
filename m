Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265772AbSKAVst>; Fri, 1 Nov 2002 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbSKAVst>; Fri, 1 Nov 2002 16:48:49 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:35777 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S265782AbSKAVss>; Fri, 1 Nov 2002 16:48:48 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 1 Nov 2002 23:43:27 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.45: initrd broken?
Message-ID: <20021101224327.GA3303@bytesex.org>
References: <20021101123132.GA30901@bytesex.org> <Pine.GSO.4.21.0211011117450.20793-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211011117450.20793-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch below fixes these.  It also changes order of blkdev_put()/del_gendisk()
> in initrd_release() - better safe than sorry.
> 
> It got initrd working on my boxen...

[ patch snipped ]

Initrd works now, thanks.

The box still doesn't boot through, the initrd fails to load the ext3
module due to unresolved symbols (mb_cache_*).  That issue looks like a
kbuild problem to me:  I have ACL's enabled (which builds the mbcache.o
module).  I also have the nfs server with v4 support enabled (which
doesn't build currently).  Running "make -k modules_install" does _not_
install the mbcache.o in /lib/modules/2.5.45.  I suspect this happens
due to the build error in the nfsd subdirectory.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20

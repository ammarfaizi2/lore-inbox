Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSJCQP4>; Thu, 3 Oct 2002 12:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSJCQP4>; Thu, 3 Oct 2002 12:15:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45841 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261718AbSJCQPz>; Thu, 3 Oct 2002 12:15:55 -0400
Date: Thu, 3 Oct 2002 09:22:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Michael Clark <michael@metaparadigm.com>, Kevin Corry <corryk@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <evms-devel@lists.sourceforge.net>
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
In-Reply-To: <20021003161405.A20832@infradead.org>
Message-ID: <Pine.LNX.4.44.0210030918250.2067-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Christoph Hellwig wrote:
> 
> root device should be in do_mount.c and not in obscure headers.

No, they should _not_ be in do_mount.c either. They should be in the 
driver registration, and do_mount.c should not have a random list of 
devices. 

I'm not accepting do_mount.c expansion here, simply because I don't want 
to help a horribly broken interface. You can always use a hex number 
(which is what things like lilo will install anyway, I believe, rather 
than using the "root=/dev/xxx" command line), and if people get too tired 
about remembering numbers, maybe somebody who cares will step up to the 
plate and write a reverse of "__bdevname()" and do it right.

Hint: see __bdevname in fs/block_dev.c, and realize that it does the 
"kdev->name" translation without _any_ tables at all. Think about doing 
the same the other way, by just walking the registered block devices.

		Linus


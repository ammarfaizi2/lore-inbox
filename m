Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291736AbSBHS4y>; Fri, 8 Feb 2002 13:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291738AbSBHS4q>; Fri, 8 Feb 2002 13:56:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18846 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291736AbSBHS4i>;
	Fri, 8 Feb 2002 13:56:38 -0500
Date: Fri, 8 Feb 2002 13:56:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@ns.caldera.de>,
        yodaiken <yodaiken@fsmlabs.com>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.33.0202082144350.15826-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0202081352400.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Ingo Molnar wrote:

> i'd suggest 64-bit update instructions on x86 as well, they do exist.
> spinlock only for the truly hopeless cases like SMP boxes composed of
> i486's. We really want llseek() to scale ...

Ingo, are you sure that you actually saw llseek() causing problems?
And not, say it, ext2_get_block()?

If you've got a heavy holder of some lock + lots of guys who grab it
for a short periods, the real trouble is the former, not the latter.

I'm going to send ext2-without-BKL patches to Linus - tonight or tomorrow.
I really wonder what effect that would have on the things.


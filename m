Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDMT0r>; Sat, 13 Apr 2002 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSDMT0q>; Sat, 13 Apr 2002 15:26:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28229 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S293603AbSDMT0p>; Sat, 13 Apr 2002 15:26:45 -0400
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp>
	<20020412143559.A25386@wotan.suse.de>
	<20020412222252.A25184@kushida.apsleyroad.org>
	<20020412.143150.74519563.davem@redhat.com>
	<20020413012142.A25295@kushida.apsleyroad.org>
	<20020413083952.A32648@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Apr 2002 13:19:46 -0600
Message-ID: <m1662vjtil.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> > I wonder if it is reasonable to depend on that: -- i.e. I'll only ever
> > see zeros, not say random bytes, or ones or something.  I'm sure that's
> > so with the current kernel, and probably all of them ever (except for
> > bugs) but I wonder whether it's ok to rely on that.
> 
> With truncates you should only ever see zeros. If you want this guarantee
> over system crashes you need to make sure to use the right file system
> though (e.g. ext2 or reiserfs without the ordered data mode patches or
> ext3 in writeback mode could give you junk if the system crashes at the
> wrong time). Still depending on only seeing zeroes would
> seem to be a bit fragile on me (what happens when the disk dies for 
> example?), using some other locking protocol is probably more safe.

Could the garbage from ext3 in writeback mode be considered an
information leak?  I know that is why most places in the kernel
initialize pages to 0.  So you don't accidentally see what another
user put there.

Eric
k

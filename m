Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314193AbSDMGj4>; Sat, 13 Apr 2002 02:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314194AbSDMGjz>; Sat, 13 Apr 2002 02:39:55 -0400
Received: from ns.suse.de ([213.95.15.193]:55305 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314193AbSDMGjz>;
	Sat, 13 Apr 2002 02:39:55 -0400
Date: Sat, 13 Apr 2002 08:39:52 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020413083952.A32648@wotan.suse.de>
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de> <20020412222252.A25184@kushida.apsleyroad.org> <20020412.143150.74519563.davem@redhat.com> <20020413012142.A25295@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if it is reasonable to depend on that: -- i.e. I'll only ever
> see zeros, not say random bytes, or ones or something.  I'm sure that's
> so with the current kernel, and probably all of them ever (except for
> bugs) but I wonder whether it's ok to rely on that.

With truncates you should only ever see zeros. If you want this guarantee
over system crashes you need to make sure to use the right file system
though (e.g. ext2 or reiserfs without the ordered data mode patches or
ext3 in writeback mode could give you junk if the system crashes at the
wrong time). Still depending on only seeing zeroes would
seem to be a bit fragile on me (what happens when the disk dies for 
example?), using some other locking protocol is probably more safe.

-Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314160AbSDMAWB>; Fri, 12 Apr 2002 20:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314161AbSDMAWA>; Fri, 12 Apr 2002 20:22:00 -0400
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:11706 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S314160AbSDMAWA>; Fri, 12 Apr 2002 20:22:00 -0400
Date: Sat, 13 Apr 2002 01:21:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, taka@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020413012142.A25295@kushida.apsleyroad.org>
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de> <20020412222252.A25184@kushida.apsleyroad.org> <20020412.143150.74519563.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    I'm not advocating more locking in read() -- there's no need, and it is
>    quite important that it is fast!  But I would very much appreciate an
>    understanding of the rules that relate reading, writing and truncating
>    processes.  How much ordering & atomicity can I depend on?  Anything at all?
> 
> Basically none it appears :-)
> 
> If you need to depend upon a consistent snapshot of what some other
> thread writes into a file, you must have some locking protocol to use
> to synchronize with that other thread.

Darn, I was hoping to avoid system calls.
Perhaps it's good fortune that futexes just arrived :-)

In some ways, it seems entirely reasonable for truncate() to behave as
if it were writing zeros.  That is, after all, what you see there if the
file is expanded later with a hole.

I wonder if it is reasonable to depend on that: -- i.e. I'll only ever
see zeros, not say random bytes, or ones or something.  I'm sure that's
so with the current kernel, and probably all of them ever (except for
bugs) but I wonder whether it's ok to rely on that.

-- Jamie

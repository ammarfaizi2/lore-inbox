Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129969AbRANLrS>; Sun, 14 Jan 2001 06:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130374AbRANLrH>; Sun, 14 Jan 2001 06:47:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:3338 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129969AbRANLrB>;
	Sun, 14 Jan 2001 06:47:01 -0500
Date: Sun, 14 Jan 2001 12:46:59 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010114124659.A23188@gruyere.muc.suse.de>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net> <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl> <14945.28354.209720.579437@pizda.ninka.net> <20010114115215.A22550@gruyere.muc.suse.de> <14945.34208.281500.226085@pizda.ninka.net> <20010114123310.A23011@gruyere.muc.suse.de> <14945.36695.669979.754755@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14945.36695.669979.754755@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 03:36:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 03:36:55AM -0800, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > How would you pass the extended errors? As strings or as to be
>  > defined new numbers? I would prefer strings, because the number
>  > namespace could turn out to be as nasty to maintain as the current
>  > sysctl one.
> 
> Textual error messages for system calls never belong in the kernel.
> Put it in glibc or wherever.

This just means that a table needs to be kept in sync between glibc and
netlink, and if someone e.g. gets a new CBQ module he would need to update
glibc. It's also bad for maintainers, because patches for tables of number 
tend to always reject ;) 

Textual error messages are e.g. used by plan9 and would be somewhat similar
to /proc. It would probably waste a few bytes in the kernel, but that's not
too bad, given the work it saves. e.g. rusty's code usually has a debug option 
that you can set and where each EINVAL outputs a error message; i always found 
that very useful and sometimes hacked that into other subsystems in my 
private tree.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

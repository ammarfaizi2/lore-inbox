Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRAXMjT>; Wed, 24 Jan 2001 07:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbRAXMjJ>; Wed, 24 Jan 2001 07:39:09 -0500
Received: from coruscant.franken.de ([193.174.159.226]:64774 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S131426AbRAXMjE>; Wed, 24 Jan 2001 07:39:04 -0500
Date: Wed, 24 Jan 2001 13:37:40 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Daniel Stone <daniel@kabuki.eyep.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
Message-ID: <20010124133740.W6055@coruscant.gnumonks.org>
In-Reply-To: <20010120144616.A16843@vitelus.com> <E14K7UY-0004hB-00@kabuki.eyep.net> <20010120153403.A17269@vitelus.com> <E14K83B-0004lQ-00@kabuki.eyep.net> <20010120160843.A17947@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010120160843.A17947@vitelus.com>; from aaronl@vitelus.com on Sat, Jan 20, 2001 at 04:08:43PM -0800
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Pungenday, the 13rd day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 04:08:43PM -0800, Aaron Lehmann wrote:
> On Sun, Jan 21, 2001 at 11:08:00AM +1100, Daniel Stone wrote:
> > > That option seems to conflict with "ipfwadm (2.0-style) support".
> > > Preferably, I'd like to stay with friendly old ipfwadm rather than
> > > switching firewalling tools _again_.
> > 
> > "I'd rather stay with my friendly old pushbike than my car!"
> > So don't complain when you can't use cruise control.
> 
> ipfwadm used to support the modules. Why have the modules for ipfwadm
> been removed from the kernel source?

If you look at the code, you will discover, that a certain core-layer of 
netfilter and iptables are used all the time, regardless if you choose to
use iptables, ipchains or ipfwadm backwards compatibility.

The backwards compatibility (either ipfwadm or ipchains) modules are built
on top of this core. The frontend (setsockopt/getsockopt to userspace 
config tool) looks the same, the backend is totally different.

This is the reason why - of course - the old ip_masq_XXX helpers don't
work anymore. They are written for a kludgy old backend which isn't present
anymore.

There is no particular reason why the current ipchains / ipfwadm emulation
modules don't use the new ip_conntrack_XXX / ip_nat_XXX stuff, just nobody
got around implementing it. (there are comments at the respective position
inside the code).

If you or somebody else wants to volunteer writing this, we'll appreciate
any patches.

btw: it's probably a good idea to move this discussion to 
netfilter@lists.samba.org

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

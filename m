Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRCPN6w>; Fri, 16 Mar 2001 08:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRCPN6n>; Fri, 16 Mar 2001 08:58:43 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:35210 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129568AbRCPN63>;
	Fri, 16 Mar 2001 08:58:29 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15026.7115.212614.6228@harpo.it.uu.se>
Date: Fri, 16 Mar 2001 14:57:31 +0100
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Andries.Brouwer@cwi.nl, lars@larsshack.org, mikpe@csd.uu.se,
        amnet@amnet-comp.com, hch@caldera.de, jjasen1@umbc.edu,
        linux-kernel@vger.kernel.org, util-linux@math.uio.no
Subject: Re: [util-linux] Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <200103160051.f2G0pgH00998@webber.adilger.int>
In-Reply-To: <UTC200103152331.AAA2159588.aeb@vlet.cwi.nl>
	<200103160051.f2G0pgH00998@webber.adilger.int>
X-Mailer: VM 6.76 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > Andries writes:
 > > > I've implemented a patch for util-linux-2.11a
 > > > which adds LABEL support to mkswap(8) and swapon/swapoff(8).
 > > 
 > > But I would prefer a somewhat more ambitious approach.
 > > 
 > > My first thought was: why label individual swap partitions?
 > > I almost never want to distinguish swap partitions, and just do
 > > "swapon -a". In case one wants to guard against changing device names,
 > > why not add an option -A so that "swapon -A" does swapon on each
 > > partition with a swap signature?
 > > 
 > > However, that would greatly increase the risk that exists already
 > > today: someone has a swap partition, and does mkfs.foo, and
 > > it so happens that foofs does not use the sector with the swapsignature.
 > > Now this foofs partition has a swap signature, but we would be very
 > > unhappy if it were used as swap space.
 > 
 > I think the LABEL is a good intermediate step for people not using LVM.
 > It basically allows your /etc/fstab to not have _any_ device names in it.

Exactly. IMO, it doesn't really help having LABEL= on your ext2 partitions
in /etc/fstab if you cannot also do the same on swap partitions.
My LABEL= patch for mkswap/swapon may not be as sexy as a brand new partition
table format [which arguably is the better solution in the long run], but it
does provide a useful improvement NOW with minimal implementation cost and full
compatibility with existing 2.2/2.4 kernels.

 > I'm not sure I would be happy with auto-mounting swap partitions,
 > especially because this would overwrite any data in the partition.  Bad.

Me too. I can easily add Andries' "swapon -A" to my patch, but I really
don't think that semantics should be the default.

Cheers,

/Mikael

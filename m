Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbRAGPdf>; Sun, 7 Jan 2001 10:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbRAGPdZ>; Sun, 7 Jan 2001 10:33:25 -0500
Received: from mail.zmailer.org ([194.252.70.162]:37390 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129784AbRAGPdR>;
	Sun, 7 Jan 2001 10:33:17 -0500
Date: Sun, 7 Jan 2001 17:33:06 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
Message-ID: <20010107173306.C25076@mea-ext.zmailer.org>
In-Reply-To: <3A57EB5E.966C91DA@candelatech.com> <E14FG60-0002eP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14FG60-0002eP-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 07, 2001 at 01:42:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:42:50PM +0000, Alan Cox wrote:
> > + *      NOTE:  That is no longer true with the addition of VLAN tags.  Not
> > + *             sure which should go first, but I bet it won't make much
> > + *             difference if we are running VLANs.  The good news is that
> 
> It makes a lot of difference tha the vlan goes 2nd. Most sane people wont
> have vlans active on a high load interface.

	VLAN tag header appears as Layer-3 protocol, which then
	causes loop into VLAN reception code and back to generic
	Layer-3 receiver.

	I just tried to pull data from another machine, which
	is on normal port thru VLAN trunking port to receiving
	machine, and got fast-ether at wire speed. (As near as
	ncftp's 11.11 MB/sec is wirespeed..)

> So fix the algorithm. You want the list sorted at this point, or to generate
> a bitmap of free/used entries and scan the list then scan the map
> 
> Question: How do devices with hardware vlan support fit into your model ?

	Hardware VLAN support at several network cards is just
	to recognize VLAN tags, and then do the right thing
	( = skip 4 bytes ) when doing TCP/UDP checksum.

> Alan

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

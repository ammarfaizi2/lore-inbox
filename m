Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129714AbQKJKwa>; Fri, 10 Nov 2000 05:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbQKJKwU>; Fri, 10 Nov 2000 05:52:20 -0500
Received: from mail.zmailer.org ([194.252.70.162]:52232 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130235AbQKJKwD>;
	Fri, 10 Nov 2000 05:52:03 -0500
Date: Fri, 10 Nov 2000 12:51:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Constantine Gavrilov <const-g@xpert.com>
Cc: willy tarreau <wtarreau@yahoo.fr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001110125150.G13151@mea-ext.zmailer.org>
In-Reply-To: <20001110092846.29847.qmail@web1102.mail.yahoo.com> <20001110114425.E13151@mea-ext.zmailer.org> <3A0BC699.791064BE@xpert.com> <20001110121402.F13151@mea-ext.zmailer.org> <3A0BCC4C.FCE21320@xpert.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A0BCC4C.FCE21320@xpert.com>; from const-g@xpert.com on Fri, Nov 10, 2000 at 12:22:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 12:22:04PM +0200, Constantine Gavrilov wrote:
> Gee, we do not call it EtherChannel, we say CISCO calls it
> EtherChannel. Where is the infringment here? Are people that paranoid
> or it is just me who is not getting it?

	You missed my original point.

	I don't like to call it BONDING.

	"Bonding" is something where two (or more) channels carry data
	in between two participating systems.  Like Multilink-PPP, and
	ISDN Channel Bonding.  Often indeed data goes out somehow inter-
	leaved on the physical links.  (Like ISDN Channel Bonding supplies
	a transparent 128 kbps link instead of two 64 kbps links to the
	upper layers.)

	EtherChannel does select the link (out of the group) by forming
	XOR of source and destination MAC addresses (their lowest bytes),
	and then doing MODULO number-of-links on the result.

	So between systems A and B the flow goes via link 0, in between
	A and C it goes via link 1.  Add there client system D, and it
	may end up into either of the links.

	|-----------|                |------|
	|    A      |-----link-0-----| SW   |---[B]
	|           |-----link-1-----| with |---[C]
	|-----------|                |EthChn|---[D]
	                             |------|


	This gives improved throughput on congested links in between
	two switches, or major server and core switches, while preserving
	data order over the links.

	Blind bonding-type "throw packets on links 0 and 1" MAY end up
	sending ethernet frames out of sequence, which for a few LAN
	based protocols is a great source of upset.


	Beowulf systems have "bonding" in use for parallel Ethernet
	links in between two machines, however THAT is not EtherChannel
	compatible thing!

> -- 
> Constantine Gavrilov

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

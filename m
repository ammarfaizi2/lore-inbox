Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUHIEkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUHIEkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHIEkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:40:47 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:52443 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S265971AbUHIEkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:40:46 -0400
Date: Mon, 9 Aug 2004 00:40:45 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Marc Ballarin <Ballarin.Marc@gmx.de>
cc: Greg KH <greg@kroah.com>, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic /dev security hole?
In-Reply-To: <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
Message-ID: <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
References: <20040808162115.GA7597@kroah.com> <1091969260.5759.125.camel@cube>
 <20040808175834.59758fc0.Ballarin.Marc@gmx.de> <20040808162115.GA7597@kroah.com>
 <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Marc Ballarin wrote:
> +Q: Are there any security issues that I should be aware of?
> +A: When using dynamic device numbers, a given pair of major/minor numbers may
> +   point to different hardware over time. If a user has permission to access a
> +   specific device node directly and is able to create hard links to this node,
> +   he or she can do so to create a copy of the device node. When the device is
> +   unplugged and udev removes the device node, the user's copy remains.
> +   If the device node is later recreated with different permissions the hard
> +   link can still be used to access the device using the old permissions.

Just an idea for a fix for this problem: If udev would change the
permissions to 000 and ownership to root.root just before it unlinks
the device node, the copy would become useless.

Eric

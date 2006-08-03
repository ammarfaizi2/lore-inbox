Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWHCN6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWHCN6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWHCN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:58:23 -0400
Received: from mail.gmx.de ([213.165.64.21]:60832 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932475AbWHCN6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:58:22 -0400
X-Authenticated: #428038
Date: Thu, 3 Aug 2006 15:58:11 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Masover <ninja@slaphack.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060803135811.GA7431@merlin.emma.line.org>
Mail-Followup-To: David Masover <ninja@slaphack.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
	reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
	rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
	lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
	linux-kernel@vger.kernel.org
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain> <44CF9217.6040609@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF9217.6040609@slaphack.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006, David Masover wrote:

> >RAID deals with the case where a device fails. RAID 1 with 2 disks can
> >in theory detect an internal inconsistency but cannot fix it.
> 
> Still, if it does that, that should be enough.  The scary part wasn't 
> that there's an internal inconsistency, but that you wouldn't know.

You won't usually know, unless you run a consistency check: RAID-1 will
only read from one of the two drives for speed - except if you make the
system check consistency as it goes, which would imply waiting for both
disks at the same time. And in that case, you'd better look for drives
that allow to synchronize their platter staples in order to avoid the
read access penalty that waiting for two drives entails.

> And it can fix it if you can figure out which disk went.

If it's decent and detects a bad block, it'll log it and rewrite it with
data from the mirror and let the drive do the remapping through ARWE.

> >Depending how far you propogate it. Someone people working with huge
> >data sets already write and check user level CRC values for this reason
> >(in fact bitkeeper does it for one example). It should be relatively
> >cheap to get much of that benefit without doing application to
> >application just as TCP gets most of its benefit without going app to
> >app.
> 
> And yet, if you can do that, I'd suspect you can, should, must do it at 
> a lower level than the FS.  Again, FS robustness is good, but if the 
> disk itself is going, what good is having your directory (mostly) intact 
> if the files themselves have random corruptions?

Berkeley DB can, since version 4.1 (IIRC), write checksums (newer
versions document this as SHA1) on its database pages, to detect
corruptions and writes that were supposed to be atomic but failed
(because you cannot write 4K or 16K atomically on a disk drive).

-- 
Matthias Andree

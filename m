Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTAGM50>; Tue, 7 Jan 2003 07:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTAGM50>; Tue, 7 Jan 2003 07:57:26 -0500
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:46259 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id <S267322AbTAGM5Z>; Tue, 7 Jan 2003 07:57:25 -0500
Date: Tue, 7 Jan 2003 14:04:17 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andre Hedrick <andre@pyxtechnologies.com>,
       Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107140417.A12227@bouton.inet6-interne.fr>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andre Hedrick <andre@pyxtechnologies.com>,
	Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Richard Stallman <rms@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E19B401.7A9E47D5@linux-m68k.org>; from zippel@linux-m68k.org on lun, jan 06, 2003 at 05:51:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, jan 06, 2003 at 05:51:13 +0100, Roman Zippel wrote:
> Hi,
> 
> > If you know anything about iSCSI RFC draft and how storage truly works.
> > Cisco gets it wrong, they do not believe in supporting the full RFC.
> > So you get ERL=0, and now they turned of the "Header and Data Digests",
> > this is equal to turning off the iCRC in ATA, or CRC in SCSI between the
> > controller and the device.  For those people who think removing the
> > checksum test for the integrity of the data and command operations, you
> > get what you deserve.
> 
> Ever heard of TCP checksums? Ever heard of ethernet checksums? Which
> transport doesn't use checksums nowadays? The digest makes only sense if
> you can generate it for free in hardware or for debugging, otherwise
> it's only a waste of cpu time. This makes the complete ERL 1 irrelevant
> for a software implementation. With block devices you can even get away
> with just ERL 0 to implement transparent recovery.
>

Some others already stated that TCP checksums aren't reliable enough.
I'll add to these remarks the following :

2 years ago we installed a Linux based VPN for one of our customers. We got
anomaly reports where the symptoms were "SMB transfers died unexpectedly".
We suspected a bug in the Windows 2000 SMB client code that talked to the
Samba server accross the VPN link (very large files over slow and long path,
this was not exactly the usual environment for an SMB client code thought
for the LAN) until I tested scp transfers between the two routers.

Scheduling scp transfers/md5 checks during a whole day revealed that some
files were corrupted.
We guessed that one router along the path recomputed TCP checksums unconditionnaly
(even if the packets arrived corrupted) and this was confirmed by other
customers of the same ISP.

Next time we will use a more robust VPN than vtun :)

If you want to use iSCSI in an uncontrolled environment you can't trust the
data transport. This is sad, but many vendors violates RFCs on a regular
basis.

I've even learned recently that one vendor developped quite some time ago a
TCP stack that pre-ACKed packets in order to speed up transfers !
As you can guess they didn't have much success out of their labs...

LB

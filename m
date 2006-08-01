Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWHARBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWHARBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWHARBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:01:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14291 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751558AbWHARBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:01:24 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Masover <ninja@slaphack.com>
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44CF84F0.8080303@slaphack.com>
References: <200607312314.37863.bernd-schubert@gmx.de>
	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
	 <1154446189.15540.43.camel@localhost.localdomain>
	 <44CF84F0.8080303@slaphack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 18:19:30 +0100
Message-Id: <1154452770.15540.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 11:44 -0500, ysgrifennodd David Masover:
> Yikes.  Undetected.
> 
> Wait, what?  Disks, at least, would be protected by RAID.  Are you 
> telling me RAID won't detect such an error?

Yes.

RAID deals with the case where a device fails. RAID 1 with 2 disks can
in theory detect an internal inconsistency but cannot fix it.

> we're OK with that, so long as our filesystems are robust enough.  If 
> it's an _undetected_ error, doesn't that cause way more problems 
> (impossible problems) than FS corruption?  Ok, your FS is fine -- but 
> now your bank database shows $1k less on random accounts -- is that ok?

Not really no. Your bank is probably using a machine (hopefully using a
machine) with ECC memory, ECC cache and the like. The UDMA and SATA
storage subsystems use CRC checksums between the controller and the
device. SCSI uses various similar systems - some older ones just use a
parity bit so have only a 50/50 chance of noticing a bit error.

Similarly the media itself is recorded with a lot of FEC (forward error
correction) so will spot most changes.

Unfortunately when you throw this lot together with astronomical amounts
of data you get burned now and then, especially as most systems are not
using ECC ram, do not have ECC on the CPU registers and may not even
have ECC on the caches in the disks.

> > The sort of changes this needs hit the block layer and ever fs.
> 
> Seems it would need to hit every application also...

Depending how far you propogate it. Someone people working with huge
data sets already write and check user level CRC values for this reason
(in fact bitkeeper does it for one example). It should be relatively
cheap to get much of that benefit without doing application to
application just as TCP gets most of its benefit without going app to
app.

Alan


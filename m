Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUALRId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUALRId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:08:33 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:5605 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id S266159AbUALRIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:08:19 -0500
Date: Mon, 12 Jan 2004 18:07:44 +0100
Message-Id: <200401121707.i0CH7iQ11796@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: "Kai Krueger" <kai.a.krueger@web.de>
To: "BartSamwel" <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> schrieb am 12.01.04 14:47:20:
> 
> Jan De Luyck wrote:
> >>2. Stop klogd, do "echo 1 > /proc/sys/vm/block_dump" and see which
> >>process keeps your disk spun up using dmesg.
> > 
> > Welll.... i see no READs, and the writes i see is spamd, kmail, pdflush, 
> > reiserfs/0.
> 
> How are the WRITEs grouped, are they grouped together or do they seem to 
> occur more evenly spaced? When you use "sync", how long until the next 
> WRITE? What are the values of /proc/sys/vm/dirty_expire_centisecs and 
> /proc/sys/vm/dirty_writeback_centisecs? Are you sure you are running a 
> kernel that supports the commit= option with reiserfs? (This option was 
> added in 2.6.1.)
> 
> I've never tested laptop mode with reiserfs BTW, does anybody else here 
> have experience with laptop mode and reiserfs?

I'm currently trying kernel 2.6.1-mm1 with laptop-mode on a reiserfs partition.
If I kill all daemons running on the system and do nothing with it, I can achieve the 10 minutes spin down time I had expected from laptop-mode. However as soon as I start up X with KDE I get regular spin ups every 30 seconds. Looking at the output of "echo 1 > /proc/sys/vm/block_dump", I see an entry every 30 seconds of "kdeinit(15145): WRITE block 65680 on hda1" followed by a whole load of "reiserfs/0(12): dirtied page" and "reisers/0(12): WRITE block XXXXX on hda1".

Due to the regular 30 second interval writes of kdeinit: kded to block 65680, laptop-mode is not particularly usable on this system.
Is this a problem with reiserfs or with kde and is there any fix available?

> 
> -- Bart

Kai
______________________________________________________________________________
Erdbeben im Iran: Zehntausende Kinder brauchen Hilfe. UNICEF hilft den
Kindern - helfen Sie mit! https://www.unicef.de/spe/spe_03.php


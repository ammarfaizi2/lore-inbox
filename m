Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVA2Szd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVA2Szd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVA2Szd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:55:33 -0500
Received: from gprs213-58.eurotel.cz ([160.218.213.58]:27520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261528AbVA2Sz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:55:28 -0500
Date: Sat, 29 Jan 2005 19:55:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5 and ATA disk failure/recovery modes
Message-ID: <20050129185515.GA2146@elf.ucw.cz>
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de> <20050127063131.GA29574@schmorp.de> <20050127095102.GA88779@muc.de> <20050127163323.GA7474@schmorp.de> <20050129183511.GA2055@elf.ucw.cz> <20050129183731.GA40659@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129183731.GA40659@muc.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, you could set stripe size to 512B; that way, RAID-5 would be
> > *very* slow, but it should have same characteristics as normal disc
> > w.r.t. crash. Unrelated data would not be lost, and you'd either get
> > old data or new data...
> 
> When you lose a disk during recovery you can still lose
> unrelated data (any "sibling" in a stripe set because its parity
> information is incomplete).  RAID-1 doesn't have this problem though.

You are right, I'd have to do soething very special... Like if I know
it is 4K filesystem, raid-5 from 5 disks could do the trick. Like

Disk1		Disk2		Disk3		Disk4		Disk5
bytes0-511	512-1023	1024-1535	1536-2048	parity
....

....no, even that does not work. You could add single bit for each 4K
saying "this stripe is being written" (with barriers etc) and return
read errors if bit is set might actually do the trick, but that's no
longer raid-5... (Can ext3 handle error in journal?)
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

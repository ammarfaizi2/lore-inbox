Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757125AbWK0QCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125AbWK0QCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758341AbWK0QCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:02:08 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:1731 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1757125AbWK0QCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:02:07 -0500
Date: Mon, 27 Nov 2006 17:01:44 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Allow turning off hpa-checking.
Message-ID: <20061127160144.GB2352@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain> <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain> <20061121115117.GU6851@gamma.logic.tuwien.ac.at> <20061121120614.06073ce8@localhost.localdomain> <20061122105735.GV6851@gamma.logic.tuwien.ac.at> <20061123170557.GY6851@gamma.logic.tuwien.ac.at> <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127133044.28b8b4ed@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 01:30:44PM +0000, Alan wrote:
> HPA has nothign to do with sector remapping.

What the drive reports as "native" capacity indeed does
*not* take into (negative-)account those sectors, that have
been remapped.   So after real remaining capacity has dropped
below original capacity,  querying the "native" size still
returns the original size, which is no longer physically
backed.

This is, I admit, practically irrelevant, because such 
drives should really be dumped before doing any harm 
to one's precious data, but please read further...

> HPA simply allows the BIOS (or disk by jumper option)
> to hide part of the drive early in boot so that it doesn't
> confuse/break old OS/BIOS code,

This pattern is probably of vanishing importance with modern
BIOS's (caring less and less about too large disks) and old
old OS's (being less and less runnable on modern hardware despite
these kinds of hacks).


> or to use it to hide things like windows reinstall images.

I see it as a rational wish to not interfere with *these*
reserved sectors (e.g. when installing linux parallel to
windows), even for correctly working drives.

I ask for a module/boot-option to allow to skip hpa-checks
generally, or even for specific drives - to be used, if one
needs to be sure that these reserved sectors of a connected
drive are not going to be touched, even when re-partitioning
the disk.   Afterall that's why they are reserved in the
first place.

That said, it's surely good to be able to access them, if one
desires so.


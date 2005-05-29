Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVE2XFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVE2XFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 19:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVE2XFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 19:05:09 -0400
Received: from animx.eu.org ([216.98.75.249]:59308 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261374AbVE2XE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 19:04:56 -0400
Date: Sun, 29 May 2005 19:01:38 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID-5 design bug (or misfeature)
Message-ID: <20050529230137.GA18854@animx.eu.org>
Mail-Followup-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> RAID-5 has rather serious design bug --- when two disks become temporarily
> inaccessible (as it happened to me because of high temperature in server
> room), linux writes information about these errors to the remaining disks
> and when failed disks are on line again, RAID-5 won't ever be accessible.

I ran into this myself, however, I had 10 disks (5 per channel) and one
chennel went down.  Ok, my array was dead at that point and I had to reboot. 
What luck, the arry wasn't usable anymore.  My /usr was on that array, but
my / was not.  I did not want to go through the initrd/initramfs thing at
the time to setup my / with raid5, plus the fact you truely cannot boot from
it (thus partitioning and setting aside a slice wasn't viable to me)

> RAID-HOWTO lists some actions that can be done in this case, but none of
> them can be done if root filesystem is on RAID --- the machine just won't
> boot.

I had to reconstruct the array by hand with mdadm.  evms wouldn't touch it. 
Fortunately, I had a copy of each disk's information and the raid5's
information in files so it was quite easy to rebuild.  I did have backups
but that wasn't really what I wanted to do.  (It did take over 2 hours
before I could return to normal.  evms can't handle a raid5 that was in
reconstruction.  I think newer versions have this fixed.)

> I think Linux should stop accessing all disks in RAID-5 array if two disks
> fail and not write "this array is dead" in superblocks on remaining disks,
> efficiently destroying the whole array.

That'd be nice =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

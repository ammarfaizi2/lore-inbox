Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTKAI2C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 03:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTKAI2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 03:28:02 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:36057 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S262575AbTKAI17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 03:27:59 -0500
Date: Sat, 1 Nov 2003 10:27:46 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
Cc: linux-kernel@vger.kernel.org
Subject: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031101082745.GF4640@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Jeffrey E. Hundstad" <jeffrey@hundstad.net>,
	linux-kernel@vger.kernel.org
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FA30F4A.5030500@hundstad.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 07:41:30PM -0600, you [Jeffrey E. Hundstad] wrote:
> Try:
> 
> hdparm -W0 /dev/hdX
> 
> for each of your ide drives.  This turns off write-caching which is 
> usually a bad thing with ide drives anyway.

According to hdparm, write caching is indeed enabled for all the drives.
I find it somewhat odd if this was the cause, though. Before reboot, the
drives were not being written to for quite a while (the fs had been
unmounted and the raid array had been stopped.) 

I suppose it _is_ possible that the drives were updating the ext2 superblock
from their write cache when power went off. The md5sum of first 1MB of the
drives was probably in sync before reboot because I got it from kernel's
cache (or drive's cache), although the up-to-date data had not been written
onto the platter yet. Also, as this is a raid5 array, one of the drives
could have been clean because the ext2 superblock (that I assume was being
updated) is physically located on only two of the drives.

I can try to turn of write caching well before next reboot. I don't
suppose there is a way to boot so that the write caching would be off all
the time - the best I can do is turn it off early in boot scripts, no?

Does anyone know if there is a crucial write caching / flushing fix in
2.4/2.6 that hasn't been merged into 2.2 (I am using the newest 2.4 ide
backport from Krzysztof Olêdzk (ide-2.2.21-06162002)). 

I don't suppose there is a away to explicitly flush the IDE drive write
cache from user space?

Or is this likely to be a drive firmware problem (kernel tries to flush the
drives, but they don't do it early enough?) How long do ide drives normally
hold data in write cache if they are idle?

The drives are SAMSUNG SV8004H, FwRev=QR100-07, fwiw.

Turning off write caching permanently doesn't sound inviting though, as
it'll probably ruin the raid performance completely...


-- v --

v@iki.fi

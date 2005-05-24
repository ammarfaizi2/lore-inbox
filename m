Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVEXAZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEXAZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEXAZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:25:39 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:45992 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261221AbVEXAYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:24:35 -0400
Message-ID: <4292743C.4040409@comcast.net>
Date: Mon, 23 May 2005 20:24:28 -0400
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree
References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net> <4292628E.4090209@pobox.com>
In-Reply-To: <4292628E.4090209@pobox.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
> akpm@osdl.org wrote:
>> The patch titled
>>
>>      Enable reads on Plextor 712-SA on 2.6.11.5
>>
>> has been added to the -mm tree.  Its filename is
>>
>>      enable-reads-on-plextor-712-sa-on-26115.patch
>>
>> Patches currently in -mm which might be from andystewart@comcast.net are
>>
>> enable-reads-on-plextor-712-sa-on-26115.patch
> 
> Andrew -- The use of the word 'hack' didn't trigger any response??

HI Jeff et al,

If you are referencing the commented out debug messages, I apologize,
and will endeavor to omit those in the future.

> 
> By hardcoding so much of the inquiry data, this patch -overwrites- valid
> inquiry data provided by the device, with generic data.  This patch
> makes generic the probe data that the SCSI layer -depends on to be
> different-.

The SCSI inquiry command does not work on this device for reasons
unknown to me.  I saw in the code where the SCSI inquiry command was
"emulated", or handled in software, for ATA devices.  I simply copied
that method for ATAPI devices.  At least that was my intent.  I cloned
one function, modified it slightly, and (I thought) called it in a
reasonable place.

> 
> Effectively you made one CD-ROM device work, killed all the others, and
> enabled an oops generator.

I fail to see how other devices would have been killed by this patch.
The inquiry data were simply moved from one data structure to another.

I tested this patch on my system with many different reads, mounts, and
unmounts and never generated an oops.  Would you tell me what you did
that caused an oops?  That would help me to improve my testing before
attempting to submit future patches.

> 
> Good show.

Aw, come on, Jeff.  I gave it a shot, I'm trying to give back to the
community rather than simply complain.  OK, so my work isn't perfect,
and you've pointed ont valid technical reasons why.  At least *I tried*
to contribute code rather than just offering complaints, and I'm willing
to admit that I'll need to try harder in the future.

> 
> Even if this patch worked, you still need to fix the following:
> 
> * Patch INQUIRY data -slightly- to fool the SCSI layer into working
> correctly.  This is what Andy's patch [poorly] attempts to address.
> * Handling DRQ interrupts (early patch exists)
> * Padding DMA data (50% patch exists)
> * Fix error handling (patch exists)
> * Fix all FIS-based drivers so that an error doesn't cause an oops
> * Implement non-polled REQUEST SENSE error handling for FIS-based drivers

As with any patch, it is completely at the discretion of the kernel
developers as to whether it gets included.  If you believe this patch is
inappropriate, then please ask Andrew Morton to remove it, and I'll
respect the decision.

Thanks for looking at the code and for offering your comments.

Andy

- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCknQ8Hl0iXDssISsRAtvpAKCBwfatiK8bLCSTz6EztI+C50KP2QCeM7vd
TCIX1cYtKEdsQK8zRTNr0Do=
=ZZKj
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284079AbRLALsJ>; Sat, 1 Dec 2001 06:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284076AbRLALr7>; Sat, 1 Dec 2001 06:47:59 -0500
Received: from hera.cwi.nl ([192.16.191.8]:1785 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S280620AbRLALrn>;
	Sat, 1 Dec 2001 06:47:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Dec 2001 11:47:34 GMT
Message-Id: <UTC200112011147.LAA114060.aeb@cwi.nl>
To: adilger@turbolabs.com, aia21@cus.cam.ac.uk
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andreas Dilger <adilger@turbolabs.com>

    > Please consider below patch which adds the starting sector and number of
    > sectors to /proc/partitions.

    Please do not accept as-is.  This breaks the format of /proc/partitions
    terribly, and all of the code that looks at it (fsck, mount, etc).

Indeed.

    Rather add the start_sect and nr_sects parameters _after_ the name
    parameter, and it will be "mostly" ok.

No. It will still break things.

    While we are at it, how about adding the partition type to the output?

The present /proc/partitions has minimal content.
Its only function is to report to user space which block devices
are known to the kernel. User space is unable to figure that out
on its own without an unreasonable amount of probing.

But once you know what devices exist, it is very easy for user space
to report all desired properties of these devices.
Do you want starting sector and size of /dev/hde4?

# hdparm -g /dev/hde4

/dev/hde4:
 geometry     = 70780/16/63, sectors = 1670760, start = 69673905

Adding such stuff to the kernel would be especially unfortunate if,
as I did in my version of the block layer, the unit becomes byte
instead of sector. We would have to change again.


Andries

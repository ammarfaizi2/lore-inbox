Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284135AbRLAQHo>; Sat, 1 Dec 2001 11:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284137AbRLAQHe>; Sat, 1 Dec 2001 11:07:34 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:23733 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284135AbRLAQH1>; Sat, 1 Dec 2001 11:07:27 -0500
Message-Id: <5.1.0.14.2.20011201155441.00ac98f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 01 Dec 2001 16:07:11 +0000
To: Andries.Brouwer@cwi.nl
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: adilger@turbolabs.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <UTC200112011147.LAA114060.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:47 01/12/01, Andries.Brouwer@cwi.nl wrote:
>     From: Andreas Dilger <adilger@turbolabs.com>
>
>     > Please consider below patch which adds the starting sector and 
> number of
>     > sectors to /proc/partitions.
>
>     Please do not accept as-is.  This breaks the format of /proc/partitions
>     terribly, and all of the code that looks at it (fsck, mount, etc).
>
>Indeed.
>
>     Rather add the start_sect and nr_sects parameters _after_ the name
>     parameter, and it will be "mostly" ok.
>
>No. It will still break things.

Sure. I anticipated it would break things but then again it is 2.5.1-pre5 
and not 2.4.x.

>    While we are at it, how about adding the partition type to the output?
>
>The present /proc/partitions has minimal content.
>Its only function is to report to user space which block devices
>are known to the kernel. User space is unable to figure that out
>on its own without an unreasonable amount of probing.
>
>But once you know what devices exist, it is very easy for user space
>to report all desired properties of these devices.
>Do you want starting sector and size of /dev/hde4?
>
># hdparm -g /dev/hde4

Ah, thanks! I didn't know that one.

>/dev/hde4:
>  geometry     = 70780/16/63, sectors = 1670760, start = 69673905
>
>Adding such stuff to the kernel would be especially unfortunate if,
>as I did in my version of the block layer, the unit becomes byte
>instead of sector. We would have to change again.

So you are going to change it anyway at some point? We could just make the 
changes at the same time in that case? If it is in bytes even better. Just 
give start byte and length, who cares about number of blocks anyway... (-; 
(Yes I can see there would be a problem with distinguishing the two but 
that can be solved.)

This is not a performance critical piece of code and having just the size 
of the partition is no way near as useful as having the start of it, too. 
And I agree with Andreas the partition type would be useful in the display, 
too.

If it really is only a list of available devices why show the size in 
blocks at all?

Utilities will adapt. That's what Documentation/Changes is for and this is 
a development kernel after all.

It's just the same as fairly recently my network refused to work because my 
network utilities disagreed with my kernel on how to communicate with each 
other...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


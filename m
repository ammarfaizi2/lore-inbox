Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbQLIHKx>; Sat, 9 Dec 2000 02:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbQLIHKo>; Sat, 9 Dec 2000 02:10:44 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:53832 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S130216AbQLIHK0>;
	Sat, 9 Dec 2000 02:10:26 -0500
Message-ID: <3A31D3BC.46FBFBEB@Rikers.org>
Date: Fri, 08 Dec 2000 23:39:56 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: shane@agendacomputing.com
CC: Daniel Quinlan <quinlan@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: cramfs filesystem patch
In-Reply-To: <200012080511.VAA02305@sodium.transmeta.com> <0012090153240K.23219@www.easysolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to see these patches as well. They may be useful on the iPAQ
(and similar hardware like my Yopy here... ;-)

I wish some hardware vendor out there would build an x86 box that used
memory addressable flash from 0 up and RAM up higher. A simple Linux
kernel boot loader could then replace the BIOS. Flash would be less
expensive than 8086 lower memory windowed flash hacks.

Has any work been done on e2compr in 2.4 yet?

Shane Nay wrote:
> 
> On Friday 08 December 2000 05:11, Daniel Quinlan wrote:
> > Here's a patch for the cramfs filesystem.  Lots of improvements and a
> > new cramfsck program, see below for the full list of changes.
> >
> > It only modifies cramfs code (aside from adding cramfs to struct
> > super_block) and aims to be completely backward-compatible.  All old
> > cramfs images will still work and new cramfs images are mountable on
> > old kernels if you avoid using holes (requires 2.3.39 or later) and
> > you don't pad the beginning of the cramfs filesystem for a boot sector
> > (and presumably, you have a new kernel in that case).
> >
> > Most of this code has been fairly well-tested, but a few features are
> > newer and less well-tested (like the directory sorting).
> >
> > If you use cramfs, please try it out and let me know if you have any
> > feedback or comments (please Cc me if you respond here).
> >
> >   Dan
> >
> 
> I've read the patch, and the added benefits of sorting seem usefull.  I have
> some general questions with regard to direction for Cramfs while the subject
> is broached however.
> 
> On the Agenda we use cramfs as our storage mechanism, with some linear
> addressing patches since it's on flash, and the memory copies inherent with a
> block device are unnecesary in our case.  (And we kill the buffer of
> compressed data in cramfs, as it's unnecessary as well)  Going forward though
> we're working on some other modifications of the the cramfs filesystem that
> allow it todo some other stuff that requires an expansion of the inode, Linus
> mentions in the README for cramfs that it may be usefull to expand it, but I
> wanted to get peoples reactions on expanding it by 32bits, and using a part
> of that to denote file information like type of compression, etc.
> 
> I had worked previously on hacking in LZO compression into cramfs, but hadn't
> had time to finish when called onto other things.  The other thing we're
> working on with ROMDISK is putting in XIP mode for binaries/libs that we're
> going to leave uncompressed, and aligned so they don't need to be copied to
> memory before executing.  I'd like to integrate XIP into cramfs at some point
> to allow the flash releases from agenda to be released as a single unit, but
> doing so necesitates an expansion of the inode to denote this information
> about certain executables/libs.  So what do you all think of expanding the
> inode for this purpose, and is loss of backward compatibility a massivly evil
> thing, so when I make this patch I need to keep information based on the
> magic of the cramfs filesystem to denote versioning information to allow for
> the difference in the inode.
> 
> Thanks,
> Shane.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

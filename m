Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbQLHKXr>; Fri, 8 Dec 2000 05:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130121AbQLHKXh>; Fri, 8 Dec 2000 05:23:37 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:35006 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S131744AbQLHKXZ>; Fri, 8 Dec 2000 05:23:25 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
Date: Sat, 9 Dec 2000 01:53:24 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: quinlan@transmeta.com
To: Daniel Quinlan <quinlan@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200012080511.VAA02305@sodium.transmeta.com>
In-Reply-To: <200012080511.VAA02305@sodium.transmeta.com>
Subject: Re: cramfs filesystem patch
MIME-Version: 1.0
Message-Id: <0012090153240K.23219@www.easysolutions.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2000 05:11, Daniel Quinlan wrote:
> Here's a patch for the cramfs filesystem.  Lots of improvements and a
> new cramfsck program, see below for the full list of changes.
>
> It only modifies cramfs code (aside from adding cramfs to struct
> super_block) and aims to be completely backward-compatible.  All old
> cramfs images will still work and new cramfs images are mountable on
> old kernels if you avoid using holes (requires 2.3.39 or later) and
> you don't pad the beginning of the cramfs filesystem for a boot sector
> (and presumably, you have a new kernel in that case).
>
> Most of this code has been fairly well-tested, but a few features are
> newer and less well-tested (like the directory sorting).
>
> If you use cramfs, please try it out and let me know if you have any
> feedback or comments (please Cc me if you respond here).
>
>   Dan
>

I've read the patch, and the added benefits of sorting seem usefull.  I have 
some general questions with regard to direction for Cramfs while the subject 
is broached however.

On the Agenda we use cramfs as our storage mechanism, with some linear 
addressing patches since it's on flash, and the memory copies inherent with a 
block device are unnecesary in our case.  (And we kill the buffer of 
compressed data in cramfs, as it's unnecessary as well)  Going forward though 
we're working on some other modifications of the the cramfs filesystem that 
allow it todo some other stuff that requires an expansion of the inode, Linus 
mentions in the README for cramfs that it may be usefull to expand it, but I 
wanted to get peoples reactions on expanding it by 32bits, and using a part 
of that to denote file information like type of compression, etc.

I had worked previously on hacking in LZO compression into cramfs, but hadn't 
had time to finish when called onto other things.  The other thing we're 
working on with ROMDISK is putting in XIP mode for binaries/libs that we're 
going to leave uncompressed, and aligned so they don't need to be copied to 
memory before executing.  I'd like to integrate XIP into cramfs at some point 
to allow the flash releases from agenda to be released as a single unit, but 
doing so necesitates an expansion of the inode to denote this information 
about certain executables/libs.  So what do you all think of expanding the 
inode for this purpose, and is loss of backward compatibility a massivly evil 
thing, so when I make this patch I need to keep information based on the 
magic of the cramfs filesystem to denote versioning information to allow for 
the difference in the inode.

Thanks,
Shane.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132773AbRDOSQa>; Sun, 15 Apr 2001 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132776AbRDOSQU>; Sun, 15 Apr 2001 14:16:20 -0400
Received: from 13dyn209.delft.casema.net ([212.64.76.209]:59148 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132773AbRDOSQL>; Sun, 15 Apr 2001 14:16:11 -0400
Message-Id: <200104151816.UAA22871@cave.bitwizard.nl>
Subject: Re: [PATCH] NTFS comment expanded, small fix.
In-Reply-To: <Pine.SOL.3.96.1010415173424.19123A-100000@libra.cus.cam.ac.uk>
 from Anton Altaparmakov at "Apr 15, 2001 06:11:08 pm"
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Date: Sun, 15 Apr 2001 20:16:02 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <Linus.Torvalds@Helsinki.FI>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> >Also, the "start" value that is read from the record, could be much 
> larger than expected, which could lead to accessing random data. The
> fixup should fail then, and this is also patched below.
> 
> No it can't (in theory). The volume would be corrupt if it was. That kind
> of check belongs in ntfs fsck utility but not in kernel code.
> 
> In any case, the correct check, if you want one, would be:
> 
> if (start + (count * 2) > size)
> 	return 0;

Hi Anton, 

Of course this is the better check. I was being sloppy. 

I disagree with your "this belongs in an fsck-program". If this
condition triggers, then indeed, the filesystem is corrupt. But if the
"start" pointer is dereferenced, the kernel could be accessing an area
that you don't want touched (e.g. if the buffer happens to be near 
enough to the "end-of-memory", you could "Ooops" .

The kernel should validate all user-input as much as possible, and an
ntfs-formatted-floppy should count as such. 

The "fixup" routine has a bunch of "return 0" conditions. These are
similar to mine: If they trigger, the filesystem must be corrupt.
It's a sanity check, which is neccesary to keep Linux stable.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbREENxd>; Sat, 5 May 2001 09:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbREENxY>; Sat, 5 May 2001 09:53:24 -0400
Received: from 4dyn183.delft.casema.net ([195.96.105.183]:27404 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132511AbREENxV>; Sat, 5 May 2001 09:53:21 -0400
Message-Id: <200105051352.PAA14913@cave.bitwizard.nl>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca> from Richard
 Gooch at "May 4, 2001 12:20:40 pm"
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Date: Sat, 5 May 2001 15:52:46 +0200 (MEST)
CC: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> - next boot, init(8) checks the file, and if it exists, opens the root
>   FS block device and reads in each block listed in the file. The
>   effect is to warm the buffer cache extremely quickly. The head will
>   move in one direction, grabbing data as it flys by. I expect this
>   will take around 1 second

FYI: 

Around 1992 or 1993, I rewrote Minix-fsck to do this instead of
seeking all over the place.

Cut the total time to fsck my filesystem from around 30 to 28
seconds. (remember the days of small filesystems?)

That's when I decided that this was NOT an interesting project: there
was very little to be gained.

The explanation is: A seek over a few tracks isn't much slower than a
seek over hundreds of tracks. Almost any "skip" in linear access
incurs the average 6ms rotational latency anyway.

			Roger. 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

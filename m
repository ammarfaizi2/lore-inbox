Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129113AbRBAI4g>; Thu, 1 Feb 2001 03:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129389AbRBAI41>; Thu, 1 Feb 2001 03:56:27 -0500
Received: from 13dyn174.delft.casema.net ([212.64.76.174]:31504 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129113AbRBAI4U>; Thu, 1 Feb 2001 03:56:20 -0500
Message-Id: <200102010856.JAA05537@cave.bitwizard.nl>
Subject: Re: drive/block device write scheduling, buffer flushing?
In-Reply-To: <20010131185120.B3287@home.ds9a.nl> from bert hubert at "Jan 31,
 2001 06:51:21 pm"
To: bert hubert <ahu@ds9a.nl>
Date: Thu, 1 Feb 2001 09:56:12 +0100 (MET)
CC: Nathan Black <NBlack@md.aacisd.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Wed, Jan 31, 2001 at 11:52:25AM -0500, Nathan Black wrote:
> > I was wondering if there is a way to make the kernel write to disk faster. 
> > I need to maintain a 10 MB /sec write rate to a 10K scsi disk in a computer,
> > but it caches and doesn't start writing to disk until I hit about 700 MB. At
> > that point, it pauses(presumably while the kernel is flushing some of the
> > buffers) and I will have missed data that I am trying to capture.
> 
> try opening with O_SYNC, or call fsync() every once in a while. Otherwise,
> this sounds like an application for a raw device, whereby you can write
> directly to the disk, with no caching in between.

But you'll probably need to use "buffer" too. 

   capture | buffer -m 128m > outputfile

Otherwise the "fsync" can block you for say 1/10th of a second,
causing loss of a few frames. (10MB per seconds sure sounds like
video).


Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

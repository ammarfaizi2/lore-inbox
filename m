Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272080AbRIQCcX>; Sun, 16 Sep 2001 22:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272240AbRIQCcN>; Sun, 16 Sep 2001 22:32:13 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:56274 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S272080AbRIQCcD>; Sun, 16 Sep 2001 22:32:03 -0400
Message-Id: <200109170232.f8H2WM901390@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Disk errors and Reiserfs
Date: Sun, 16 Sep 2001 22:32:18 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15imSi-00068f-00@the-village.bc.nu>
In-Reply-To: <E15imSi-00068f-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 September 2001 08:40 pm, Alan Cox wrote:
> > My issue, though, is Linux did not handle it well.  Userspace actually
> > has an 'EIO' error code for this situation but, instead, any program
> > touching the mounted partition hung in a D state.
>
> Thats a reiserfs property and one you'll find in pretty much any other
> fs.

Is that the best approach?  Userspace doesn't always handle EIO well, but 
it can't do much worse than a permanent deadlock.

> > Is it possible for the kernel to handle this with enough grace that
> > you can kill the processes and unmount the partition?  (Thus allowing
> > the box to continue in a hobbled, but function manner.)  Failing that,
> > is it possible for the kernel to handle it well enough for 'shutdown'
> > to cleanly shutdown the box?
>
> Killing the process isnt neccessary, its been halted in its tracks. As
> to a clean shutdown - no chance. You've just hit a disk failure, the on
> disk state is not precisely known, writes have been lost. Nothing is
> going to make a clean shutdown possible under such circumstances.

Let me rephrase: cleanish.  At least enough to let 'shutdown' actually 
shutdown and surviving filesystems to unmount cleanly.  I guess this would 
require all file ops to that filesystem to return EIO and umount would 
drop the filesystem as-is.

	-- Brian

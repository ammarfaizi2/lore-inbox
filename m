Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266567AbRGDWs6>; Wed, 4 Jul 2001 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266568AbRGDWsj>; Wed, 4 Jul 2001 18:48:39 -0400
Received: from martnet.com ([146.145.176.8]:40653 "EHLO home.martnet.com")
	by vger.kernel.org with ESMTP id <S266567AbRGDWsg>;
	Wed, 4 Jul 2001 18:48:36 -0400
Date: Wed, 4 Jul 2001 18:48:26 -0400
From: John Guthrie <guthrie@home.martnet.com>
Message-Id: <200107042248.SAA06196@home.martnet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: unable to read from IDE tape
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200107022319.TAA19681@home.martnet.com>

Note: the following is my reply to a private reply to my initial post regarding
my problem reading from my tape drive.  I thought that this info might be
helpful on the mailing list as well.


Willem Riede <osst@riede.org> wrote:
> John Guthrie wrote:
> >
> > Hi all,
> >
> > Lately, I have been having problems reading from from my HP Colorado IDE
> > tape drive.  I can use mt to get the status of the drive and to forward the
> > drive to a different file.  I can even use tar to write to the tape.
> > But whenever I try to read the tar files that I have written to tape, I
> > get an I/O error, and there doesn't even seem to be any attempt by the
>
> Can you be more specific, and post exactly what commands you issued after
> inserting the tape, and what error you get when, including any log messages?

First, I run

mt rewind

just to get the tape back to the beginning.  (I think that I may have /dev/tape
as asymlink to /dev/nht0, not /dev/ht0.)  Then just as a test, I can do
something like

tar -cvf /dev/nht0 /boot

This command actually runs fine with no errors.  If I then run

mt status

I get the output

SCSI 2 tape drive:
File number=0, block number=16841, partition=0.
Tape block size 512 bytes. Density code 0x0 (default).
Soft error count since last status=0
General status bits on (0):

At least the block number is non-zero as I should expect it to be since
I did the tar to /dev/nht0.  If I then run

mt rewind; mt status

I get the output

SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x0 (default).
Soft error count since last status=0
General status bits on (0):

So now the block number is at 0, which is good since I did just rewind the
thing.  At this point, I would expect (perhaps mistakenly) that I should
be able to run the following

tar -tf /dev/ht0

The output of this command is

tar: /dev/ht0: Cannot read: Input/output error
tar: At beginning of tape, quitting now
tar: Error is not recoverable: exiting now

>
> > driver to read the tape.  This is currently happening under 2.4.5, and
> > has been happening undeer at least 2.4.2 and 2.4.3, I think it was also
> > happening under 2.4.1 as well.
>
> Can you verify that (by rebooting to previous kernels if you still have them)?
> Does it happen with all your tapes?

This is the same error that I have gotten from both 2.4.2 and 2.4.3.  It
definitely happens with all of my tapes including my new ones.  (Due to
circumstanes of my setup, I can't verify 2.4.1 this exact minute, but I can
get back to you on that.)

I am also getting the following lines of dmesg output:

ide-tape: Reached idetape_chrdev_open
ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0

I don't know if this helps.  Apparently IDETAPE_DEBUG_LOG is set to 1 by
default.  Which actually results in a large number of copies of the first line.
I only get the second line when I try to open the tape for reading.

> Regards. Willem Riede.

John Guthrie
guthrie@martnet.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130949AbRCFFph>; Tue, 6 Mar 2001 00:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130950AbRCFFp1>; Tue, 6 Mar 2001 00:45:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37649 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130949AbRCFFpS>; Tue, 6 Mar 2001 00:45:18 -0500
Date: Mon, 5 Mar 2001 21:45:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Douglas Gilbert <dougg@torque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's 	
In-Reply-To: <3AA47557.1DC03D6@torque.net>
Message-ID: <Pine.LNX.4.10.10103052136580.1011-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Mar 2001, Douglas Gilbert wrote:
> 
> > On the other hand, it's also entirely possible that IDE is just a lot
> > better than what the SCSI-bigots tend to claim. It's not all that
> > surprising, considering that the PC industry has pushed untold billions of
> > dollars into improving IDE, with SCSI as nary a consideration. The above
> > may just simply be the Truth, with a capital T.
> 
> What exactly do you think fsync() and fdatasync() should
> do? If they need to wait for dirty buffers to get flushed
> to the disk oxide then multiple reported IDE results to
> this thread are defying physics.

Well, it's fairly hard for the kernel to do much about that - it's almost
certainly just IDE doing write buffering on the disk itself. No OS
involved.

The kernel VFS and controller layers certainly wait for the disk to tell
us that the data has been written, there's no question about that. But
it's also not at all unlikely that the disk itself just lies.

I don't know if there is any way to turn of a write buffer on an IDE disk.

I do remember that there were some reports of filesystem corruption with
some version of Windows that turned off the machine at shutdown (using
software power-off as supported by most modern motherboards), and shut
down so fast that the drives had not actually written out all data.
Whether the reports were true or not I do not know, but I think we can
take for granted that write buffers exist.

Now, if you really care about your data integrity with a write-buffering
disk, I suspect that you'd better have an UPS. At which point write
buffering is a valid optimization, as long as you trust the harddisk
itself not to crash even if the OS were to crash.

Of course, whether you should even trust the harddisk is another question.

			Linus


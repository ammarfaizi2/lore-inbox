Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSICQFa>; Tue, 3 Sep 2002 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSICQF3>; Tue, 3 Sep 2002 12:05:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317351AbSICQFR>; Tue, 3 Sep 2002 12:05:17 -0400
Date: Tue, 3 Sep 2002 12:09:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <200209031550.g83FogE03775@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.3.95.1020903115445.1058A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> "A month of sundays ago Rik van Riel wrote:"
> > On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> > 
> > > I assumed that I would need to make several VFS operations atomic
> > > or revertable, or simply forbid things like new file allocations or
> > > extensions (i.e.  the above), depending on what is possible or not.
> > 
> > > No, I don't want ANY FS. Thanks, I know about these, but they're not
> > > it. I want support for /any/ FS at all at the VFS level.
> > 
> > You can't.  Even if each operation is fully atomic on one node,
> > you still don't have synchronisation between the different nodes
> > sharing one disk.
> 
> Yes, I do have synchronization - locks are/can be shared between both
> kernels using a device driver mechanism that I implemented. That is
> to say, I can guarantee that atomic operations by each kernel do not
> overlap "on the device", and remain locally ordered at least (and
> hopefully globally, if I get the time thing right).
> 
> It's not that hard - the locks are held on the remote disk by a
> "guardian" driver, to which the drivers on both of the kernels
> communicate.  A fake "scsi adapter", if you prefer.
> 
> > You really need filesystem support.
> 
> I don't think so. I think you're not convinced either! But
> I would really like it if you could put your finger on an
> overriding objection.
> 
> Peter

Lets say you have a perfect locking mechanism, a fake SCSI layer
as you state. You are now going to create a new file on the
shared block device. You are careful that you use only space
that you "own", etc., so you perfectly create a new file on
your VFS.

How does the other user's of this device "know" that there is
a new file so it can update its notion of the block-device state?

You have created perfect isolation so, by definition, the other
isolated user's don't know that you have just used space that they
think that they own.

Now, the notion of a complete 'file-system' for support may not be
required. What you need is like a file-system without all the frills.
It needs to act like a "hard disk malloc" or slab allocator. That way,
you can have independence between the systems that are accessing the
device.

So, if you made this, you are still stuck with the problem of duplicate
file-names, but this could be resolved by using a "librarian" layer
so that a new file-name and its meta-data gets known by all the
users of the device.

FYI, the "librarian" layer is the file-system so, I have shown that
you need file-system support.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


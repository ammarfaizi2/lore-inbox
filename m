Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRABPzf>; Tue, 2 Jan 2001 10:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRABPzZ>; Tue, 2 Jan 2001 10:55:25 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:59176 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129561AbRABPzT>; Tue, 2 Jan 2001 10:55:19 -0500
Date: Tue, 2 Jan 2001 10:26:45 -0500 (EST)
From: <stewart@neuron.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: sync() broken for raw devices in 2.4.x??
In-Reply-To: <20010102023554.A2232@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10101021022450.585-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Thanks, Andi. In which case sync() for direct buffered block
 device access would seem to be broken in 2.4.0-prerelease.

 stewart


On Tue, 2 Jan 2001, Andi Kleen wrote:

> On Mon, Jan 01, 2001 at 07:50:31PM -0500, stewart@neuron.com wrote:
> > 
> >  I have a sync()/fdatasync() intensive application that is designed to work
> >  on both raw files and raw partitions. Today I upgraded my kernel to the
> >  new pre-release and found that my benchmark program would no longer finish
> >  when handed a raw partition. I've written a small Java program (my app is
> >  in Java) which demonstrates the bug. Make foo.dat a raw scsi partition to
> >  re-produce. In my case it's "mknod foo.dat b 8 18". 
> 
> Just a minor correction: this is not a raw partition, but a buffered blockdevice.
> If you want a real rawdevice (where sync is a noop because all IO goes
> synchronously to disk) you need to bind a character raw device to the
> block device first using the raw util.
> 
> >From a quick look sync_buffers() [which implements fsync on block devices]
> has not changed significantly between 2.2 and 2.4 and uses the same algorithm.
> 
> -Andi
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

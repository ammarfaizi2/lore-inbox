Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129894AbRABCGo>; Mon, 1 Jan 2001 21:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbRABCGe>; Mon, 1 Jan 2001 21:06:34 -0500
Received: from Cantor.suse.de ([194.112.123.193]:64779 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129477AbRABCGX>;
	Mon, 1 Jan 2001 21:06:23 -0500
Date: Tue, 2 Jan 2001 02:35:54 +0100
From: Andi Kleen <ak@suse.de>
To: stewart@neuron.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sync() broken for raw devices in 2.4.x??
Message-ID: <20010102023554.A2232@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.10.10101011925130.1859-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101011925130.1859-100000@localhost>; from stewart@neuron.com on Mon, Jan 01, 2001 at 07:50:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2001 at 07:50:31PM -0500, stewart@neuron.com wrote:
> 
>  I have a sync()/fdatasync() intensive application that is designed to work
>  on both raw files and raw partitions. Today I upgraded my kernel to the
>  new pre-release and found that my benchmark program would no longer finish
>  when handed a raw partition. I've written a small Java program (my app is
>  in Java) which demonstrates the bug. Make foo.dat a raw scsi partition to
>  re-produce. In my case it's "mknod foo.dat b 8 18". 

Just a minor correction: this is not a raw partition, but a buffered blockdevice.
If you want a real rawdevice (where sync is a noop because all IO goes
synchronously to disk) you need to bind a character raw device to the
block device first using the raw util.

>From a quick look sync_buffers() [which implements fsync on block devices]
has not changed significantly between 2.2 and 2.4 and uses the same algorithm.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286866AbRLWLSc>; Sun, 23 Dec 2001 06:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286865AbRLWLSW>; Sun, 23 Dec 2001 06:18:22 -0500
Received: from maile.telia.com ([194.22.190.16]:26365 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S286866AbRLWLSN>;
	Sun, 23 Dec 2001 06:18:13 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Andre Hedrick <andre@linux-ide.org>,
        Ben Fennema <bfennema@falcon.csc.calpoly.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet>
	<Pine.LNX.4.10.10112222312030.8976-100000@master.linux-ide.org>
	<3C258D76.BE259944@zip.com.au>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Dec 2001 12:18:01 +0100
In-Reply-To: <3C258D76.BE259944@zip.com.au>
Message-ID: <m2zo4ayyl2.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Andre Hedrick wrote:
> > 
> > Would it be great if Linux did not have such a lame design to handle the
> > these problems?  Just imaging if we had a properly formed
> > FS/BLOCK/MAIN-LOOP/LOW_LEVEL model; whereas, an error of this nature in a
> > write to media failure could be passed back up the pathway to the FS and
> > request the FS to re-issue the storing of data to a new location.
> > 
> > To bad the global design lacks this ablitity and I suspect that nobody
> > gives a damn, or even worse ever thought of this idea.
> 
> For the filesystems with which I am familiar, this feature would
> be quite difficult to implement.  Quite difficult indeed.  And given
> that it only provides recovery for write errors, its value seems
> questionable.

...

> What percentage of disk errors occur on writes, as opposed to reads?
> If errors-on-writes preponderate then maybe you're on to something.
> But I don't think they do?

One case were write errors are probably much more common than read
errors is packet writing on CDRW media. CDRW disks can only do a
limited number of writes to a given sector, and being able to remap
sectors on write errors can greatly increase the time a CDRW disk
remains usable.

The UDF filesystem has some code for bad block relocation
(udf_relocate_blocks) and the packet writing block "device" (it's a
layered device driver, somewhat like the loop device) has hooks for
requesting block relocation on I/O errors. This code is not working
yet though, and it seems quite complicated to get the relocation to
work properly when the file system is operating in asynchronous mode.

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden

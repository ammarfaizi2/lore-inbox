Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284111AbRLTKtY>; Thu, 20 Dec 2001 05:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbRLTKtP>; Thu, 20 Dec 2001 05:49:15 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:25348 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S284111AbRLTKtC>; Thu, 20 Dec 2001 05:49:02 -0500
Message-ID: <3C21C21F.92F834AB@idb.hist.no>
Date: Thu, 20 Dec 2001 11:49:03 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: jlm <jsado@mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: Poor performance during disk writes
In-Reply-To: <20011218195509.U2272-100000@gerard> <1008804413.926.5.camel@PC2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlm wrote:

> I think people might be missing the issue that I'm having, here. Let me
> see if I can clarify. I'm not too concerned about write speed. I don't
> care too much if the hard drive can only write one byte per second. The
> problem is that when the kernel decides to write out to the disk, it is
> pre-empting everything else. All output to the user in X, the sound
> card, and also text typing in the console is put "on the back burner"
> while the disk is written to.

There may be a problem here, and maybe not:

All of the actions above _may_ require disk access.  The shell you type
into could be swapped out, for example.  A slow disk will be a problem
in that case, swapin won't happen until the disk head seeks to
the relevant position, and that may be delayed by the write.  Even
if the cpu is capable of doing other work while IO is going on.

> It seems to me that smaller chunks of data can be written to the disk
> without disrupting my use of the computer (which is the case with
> untarring a small file, for instance), so if the kernel has got a lot to
> write to disk, just do that as a bunch of smaller writes and we should
> be fine.
> 
> So I guess I don't really care what mode the hard drive is operating in
> (udma, mdma, dma or plain ide), I just don't want to have to go get a
> cup of coffee while the hard drive saves some data. Is there a "don't

Devices generally get the cpu before anything else.  A good disk system
don't need much cpu.  Running IDE in PIO mode require a lot
of cpu though.   Using any of the DMA modes avoids that.

> pre-empt the rest of the system" switch for the eide drives? Is there
> something fundamental/unique going on here that I'm missing?
dma, udma, etc. is that switch.  It lets the cpu do other work (such as
redrawing X) while the disk is busy.  Plain ide is what you don't want.

The problem of waiting for other files or swapping while a really big
write
is going on is different.  Get more drives, so the big writes go
to one drive while you get stuff swapped in (or other file access)
on other drive(s).  The kernel is capable of getting fast response
from one drive while another is completely bogged down with
enormous writes.

Helge Hafting

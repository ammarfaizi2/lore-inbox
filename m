Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQKTXGk>; Mon, 20 Nov 2000 18:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQKTXGb>; Mon, 20 Nov 2000 18:06:31 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129340AbQKTXGZ>;
	Mon, 20 Nov 2000 18:06:25 -0500
Date: Mon, 20 Nov 2000 13:34:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Message-ID: <20001120133423.A221@toy>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us> <news2mail-3A15ACE3.5BED2CA3@innominate.de> <20001118164021.A156@toy> <news2mail-3A183A01.4F214A4F@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <news2mail-3A183A01.4F214A4F@innominate.de>; from news-innominate.list.linux.kernel@innominate.de on Sun, Nov 19, 2000 at 09:37:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Actually, I was planning on doing on putting in a hack to do something
> > > like that: calculate a checksum after every buffer data update and check
> > > it after write completion, to make sure nothing scribbled in the buffer
> > > in the interim.  This would also pick up some bad memory problems.
> > 
> > You might want to take  look to a patch with crc loop option.
> > 
> > It does verify during read, not during write; but that's even better because
> > that way you pick up problems in IO subsystem, too.
> 
> You would have to store the checksums on the filesystem then, or use a

I store checksums in separate partition.

> verify-after-write.  What I was talking about is a
> verify-the-buffer-didn't get scribbled.  I'd then trust the hardware to
> report a write failure.  Note that if something scribbles on your buffer
> between the time you put good data on it and when it gets transfered to
> disk, you can verify perfectly and still have a hosed filesystem.

Actually, I have 50% chance detecting that corruption. If it happens
between application and loop, I detect nothing. If it happens between
loop and disk, I catch it.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

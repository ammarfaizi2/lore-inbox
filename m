Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312241AbSCRIQc>; Mon, 18 Mar 2002 03:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312240AbSCRIQR>; Mon, 18 Mar 2002 03:16:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:48901 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312237AbSCRIQE>; Mon, 18 Mar 2002 03:16:04 -0500
Message-ID: <3C95A1DB.CA13A822@zip.com.au>
Date: Mon, 18 Mar 2002 00:14:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Anton Altaparmakov <aia21@cam.ac.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <3C945D7D.8040703@mandrakesoft.com> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> 
> On Sun, Mar 17, 2002 at 01:41:37PM +0000, Anton Altaparmakov wrote:
> > We don't need fadvise IMHO. That is what open(2) is for. The streaming
> > request you are asking for is just a normal open(2). It will do read ahead
> > which is perfect for streaming (of data size << RAM size in its current form).
> 
>         A quick real world example of where fadvise can work well.
> Imagine a database appliction that doesn't use O_DIRECT (for whatever
> reason, could even be that they don't trust the linux implementation yet
> :-).

O_DIRECT is broken against RAID0 (at least) in 2.5 at present.  The
RAID driver gets sent BIOs which straddle two or more chunks and RAID
spits out lots of unpleasant warnings.  Neil has been informed...

>  So, this database gets a query.  That query requires a full table
> scan, so it calls fadvise(fd, F_SEQUENTIAL).  Then another query does
> row-specific access, and caching helps.  So it wants to turn off
> F_SEQUENTIAL.

It'd probably be smarter for the application to hold two fds against
the same file for this sort of access pattern.


-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312151AbSCRAMp>; Sun, 17 Mar 2002 19:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312149AbSCRAMg>; Sun, 17 Mar 2002 19:12:36 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:7083 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S312148AbSCRAM1>;
	Sun, 17 Mar 2002 19:12:27 -0500
Message-Id: <5.1.0.14.2.20020318000057.051d30e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 18 Mar 2002 00:12:38 +0000
To: "Ken Hirsch" <kenhirsch@myself.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <00c101c1cdf1$1c031120$0100a8c0@DELLXP1>
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
 <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020317190303.03289ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:19 17/03/02, Ken Hirsch wrote:
>Anton Altaparmakov writes:
> > Last time I heard serious databases use their own memmory
> > management/caching in combination with O_DIRECT, i.e. they bypass the
> > kernel's buffering system completely. Hence I would deem them irrelevant
>to
> > the problem at hand...
> >
> > If a database were not to use O_DIRECT I would think it would be using
>mmap
> > so it would have madvise already... but I am not a database expert so take
> > this with a pinch of salt...
>
>I don't think that either MySQL or PostgreSQL use O_DIRECT; I just grepped
>the source and didn't find it.  They can't use mmap() because it uses up too
>much process address space.

<flame bait>So you consider these two to be serious databases?</flame bait> 
(-; [1]

>It's true that commercial databases mostly do their own scheduling and
>caching, and if they are the only thing running on your system and you tune
>them right, that works.  But it's not necessarily a good thing.  If there
>are other processes on your system, there would be a benefit if the DBMS
>could inform the operating system of its intentions.
>
>A posix_fadvise() call would be a start, but you could potentially go beyond
>that.

Ok, so basically we want both fadvise() and open(2) semantics, with the 
open(2) being a superset of the fadvise() capabilities (some things no 
longer make sense to be specified once the file is open). They can of 
course both be calling the same common helpers inside the kernel...

fadvise() would probably only be used by databases while open(2) would be 
used by the rest of the world. (-;

Best regards,

Anton

[1] Sorry about the flame bait, couldn't resist...  I know they are both 
very respectable databases and they are free software which is great.


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


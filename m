Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSD3OVv>; Tue, 30 Apr 2002 10:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313567AbSD3OVu>; Tue, 30 Apr 2002 10:21:50 -0400
Received: from borg.org ([208.218.135.231]:18490 "HELO borg.org")
	by vger.kernel.org with SMTP id <S313060AbSD3OVt>;
	Tue, 30 Apr 2002 10:21:49 -0400
Date: Tue, 30 Apr 2002 10:21:48 -0400
From: Kent Borg <kentborg@borg.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jaime Medrano <overflow@eurielec.etsit.upm.es>,
        linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
Message-ID: <20020430102148.D4470@borg.org>
In-Reply-To: <Pine.LNX.4.33.0204301411210.4658-100000@cuatro.eurielec.etsit.upm.es> <3CCE9038.F4C830B4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 01:38:16PM +0100, Arjan van de Ven wrote, very
roughly: 
[that RAID 1 is only as fast in reading as the fastest disk because of
seeking over alternate blocks, and ]

> The only way to get the "1 thread sequential read" case faster is by
> modifying the disk layout to be
> 
> Disk 1: ACEGIKBDFHJ
> Disk 2: ACEGIKBDFHJ
> 
> where disk 1 again reads block A, and disk 2 reads block B.  To read
> block C, disk 1 doesn't have to move it's head or read a dummy block
> away, it can read block C sequention, and disk 2 can read block D
> that way.
>
> That way the disks actually each only read the relevant blocks in a
> sequential way and you get (in theory) 2x the performance of 1 disk.

I am confused.  

Assuming a big enough read is requested to allow a parallelizing to
two disks, why can't the second disk be told not to read alternate
blocks but to start reading sequential blocks starting half way up the
request?

Also, why does hdparm give me significantly faster read numbers on
/dev/md<whatever> than it does on /dev/hd<whatever>?  I had assumed
there was parallelizing going on.  Does this mean I would get a speed
improvement if I ran my single disk notebook as a single disk RAID 1
because there is some bigger or better buffering going on in that code
even without parallelizing?

Thanks,

-kb

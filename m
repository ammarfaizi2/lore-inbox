Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSESUu0>; Sun, 19 May 2002 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSESUuZ>; Sun, 19 May 2002 16:50:25 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25614 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315207AbSESUuY>; Sun, 19 May 2002 16:50:24 -0400
Date: Sun, 19 May 2002 22:50:15 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4/2.5 SCSI considerably slower than FreeBSD
Message-ID: <20020519205015.GC3008@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3CE5D4FC.DB2CC47E@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Douglas Gilbert wrote:

> $ time sg_dd if=/dev/sg1 of=/dev/null bs=512 count=2m time=1
> time to transfer data was 18.786448 secs, 57.16 MB/sec
> 2097152+0 records in
> 2097152+0 records out
> real 0m18.799s  user 0m0.030s  sys 0m3.010s

In a live system (actually, it's idle, but every 5 s, there is a short
burst of disk activity -- reiserfs and ext3fs in use here, something is
going on there), sg_dd is not really better than plain dd:

> time sg_dd if=/dev/sg0 of=/dev/null count=1310720
> Assume default 'bs' (block size) of 512 bytes
> 1310720+0 records in
> 1310720+0 records out
>
> real    0m24.348s

gives: 27,56 MB/s. A little better than dd, but still much less than FreeBSD's.

> >From memory, dd's performance in the lk 2.4 series was considerably
> lower than sg_dd. No doubt FreeBSD would also perform well but I
> doubt it could beat linux (2.5) by the type of margin your measurements
> indicate. [For sequential reads, tagged queueing will not have a

It does. I trust my last figures. I don't trust the above too much
because of the bogus 5 s interval write burst. Not sure where it comes
from, ext3fs or reiserfs, I'd pretty much like something like an inverse
strace: "who is writing to my disk?"

> significant impact.] It is also worth noting that the new aic7xxx
> and sym53c8xx_2 drivers are essentially the same on Linux and
> FreeBSD (i.e. same code base, same maintainers).

I know that, and I assume it's not the fault of the drivers themselves
(that's because the "far from theoretical optimum" holds on either
hardware).

Looks like either you're lucky or like Linux has some bad VM interaction
or Linux has issues with U160-drives on UWSCSI adapters (yours does
U160, ours don't) that FreeBSD doesn't have. (FreeBSD's IDE driver is
not as good as the Linux 2.5 IDE driver, so in the end, FreeBSD and
Linux are even again ;-)

-- 
Matthias Andree

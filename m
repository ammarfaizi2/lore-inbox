Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135431AbRDMHOo>; Fri, 13 Apr 2001 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135432AbRDMHOe>; Fri, 13 Apr 2001 03:14:34 -0400
Received: from hood.tvd.be ([195.162.196.21]:63922 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S135431AbRDMHO1>;
	Fri, 13 Apr 2001 03:14:27 -0400
Date: Fri, 13 Apr 2001 09:13:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: lomarcan@tin.it
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape Corruption - update
In-Reply-To: <Pine.LNX.4.05.10104130858220.2653-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10104130907360.2653-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2001, Geert Uytterhoeven wrote:
> On Thu, 12 Apr 2001 lomarcan@tin.it wrote:
> > It seems that the tape is written incorrectly. I wrote some large file
> > (300MB)
> > and read it back four time. The read copies are all the same. They differ
> > from the original only in 32 consecutive bytes (the replaced values SEEM
> > random). Of course, 32 bytes in 300MB tar.gz files are TOO MUCH to be 
> > accepted :)
> 
> In my case, the 32 bad bytes are always a copy of the 32 bytes 10K before (10K
> = blocksize of tar). Can you verify that's the case for you as well? For
> reference, I have approx. 6 sequences of corrupted data when writing 256 MB to
> tape. Reading gives no problems.

Forgot some things...

It also happens with dd, so it's not a bug in tar.
If I set the tar blocksize to 512 bytes, the offset changes to 512 bytes as
well.
If I set the tar blocksize to 57*512 bytes, I didn't see a problem (however,
could have been `good luck').

The problem seems to be there since at least 2.4.0-test1-ac10, which means
quite some people may no longer have known good backups of their valuable data
(of course we should not run 2.[34].x kernels on our systems, right? :-)

Since you have a different SCSI host adapter, the problem is most likely in
st.c. I was thinking of writing `predictable' data (or checksummed blocks or
so) to tape and add some data verification tests to st.c at the very last
moment before it sends a write command to the SCSI host adapter, but I haven't
found time for that yet.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


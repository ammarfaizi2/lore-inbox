Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbRGTRMI>; Fri, 20 Jul 2001 13:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbRGTRL6>; Fri, 20 Jul 2001 13:11:58 -0400
Received: from hood.tvd.be ([195.162.196.21]:54605 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S267180AbRGTRLw>;
	Fri, 20 Jul 2001 13:11:52 -0400
Date: Fri, 20 Jul 2001 19:08:03 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10107081519110.9473-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10107201902150.568-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 8 Jul 2001, Geert Uytterhoeven wrote:
> New findings:
>   - The problem doesn't happen with kernels <= 2.2.17. It does happen with all
>     kernels starting with 2.2.18-pre1.
>   - The only related stuff that changed in 2.2.18-pre1 seems to be the
>     Sym53c8xx driver itself. I'll do some more tests soon to isolate the
>     problem.
>   - The changes to the Sym53c8xx driver in 2.2.18-pre1 are _huge_. Are the
>     individual changes between sym53c8xx-1.3g and sym53c8xx-1.7.0 available
>     somewhere?

The problem is indeed introduced by the changes to the Sym53c8xx in 2.2.18-pre1.
I managed to find some intermediate versions in the 2.3.x series, and here are the
results:
  - sym53c8xx-1.3g (from BK linuxppc_2_2): OK
  - sym53c8xx-1.5e: crash in SCSI interrupt during driver init
  - sym53c8xx-1.5f: lock up during driver init
  - sym53c8xx-1.5g: random 32-byte error bursts when writing to tape

Perhaps I can get 1.5e and 1.5g to work using some PPC-specific fixes from the
1.3.g driver in the linuxppc_2_2 tree (it differed a bit from the 1.3g in
Alan's 2.2.17). But even then the changes in 1.5f and 1.5g are rather small,
compared to the changes between 1.3g and 1.5f.

So I'd be very happy if I could get my hand on more intermediate versions.
Thanks for your help! I _really_ want to nail this one down!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


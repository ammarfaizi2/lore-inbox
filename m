Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRDNSKe>; Sat, 14 Apr 2001 14:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132512AbRDNSKZ>; Sat, 14 Apr 2001 14:10:25 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:9234 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S132503AbRDNSKM>; Sat, 14 Apr 2001 14:10:12 -0400
Date: Sat, 14 Apr 2001 20:08:36 +0200 (MEST)
From: Marc SCHAEFER <schaefer@alphanet.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI tape corruption problem
In-Reply-To: <Pine.LNX.4.05.10104141940320.12788-100000@callisto.of.borg>
Message-ID: <Pine.LNX.3.96.1010414200625.32701C-100000@defian.alphanet.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Geert Uytterhoeven wrote:

> Do you also mean it is illegal to use blocksize 10 kB (default tar, no gzip)
> with a tape drive??

not at all. Infact, with the default settings of the st driver, any
multiple of 512 bytes is ok.  The additional dd step is just there to be
sure everything is fine. If gzip always outputs multiple of 512 bytes then
everything is fine. I do this as precaution, since on Solaris with an old
Exabyte tape if you didn't do the extra dd you had various bizarre
problems. Linux is much nicer, but ...

Now if you change st defaults to e.g. variable block mode, then it changes
a bit the equation: you need to read exactly the same size of block (e.g.
bs=32k) else you get an error.

Variable block mode is mt -f /dev/nst0 setblk 0.



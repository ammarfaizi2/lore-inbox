Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291444AbSB0B5D>; Tue, 26 Feb 2002 20:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291436AbSB0B4u>; Tue, 26 Feb 2002 20:56:50 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:63244 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291446AbSB0Bz4>; Tue, 26 Feb 2002 20:55:56 -0500
Date: Wed, 27 Feb 2002 02:55:51 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Revisiting 2.4.X __alloc_pages: X-order allocation failed
Message-ID: <20020227015551.GA31138@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently had troubles with excessively low I/O throughput when writing
a CD from an ISO image. The image file was on a reiserfs partition on an
IBM DCAS-32160 (USCSI), attached to an AHA2940Udontaskme (AIC7881U), the
writer is ATAPI 16x.  Pentium-II/400, 256 MB, PIIX4 IDE chip (BX chip
set I believe).  SuSE official 2.4.16 kernel as offered as update for
SuSE 7.3 -- I didn't check their patches, but their recent kernels were
based on -aa stuff AFAICS.

The low throughput showed in a big (16M) but empty (0 - 4%) cdrecord
FIFO, with the drive pausing during the write (didn't harm, burnproof
was on). 2400 kByte/s (for 16x CD writing) is far below the sustained
transfer rates which range from 4.7 at ID to 7.7 MB/s at OD.

This problem didn't show with vanilla 2.4.14.

I found a lot of __alloc_pages: X-order allocation failed in my logs,
with X from 1 to 3. Do these allocation failures impair I/O throughput
when reading stuff from a disk, tossing things through a
statically-allocated FIFO to a CD writer? If so, I might need to give
that box some other kernel.

-- 
Matthias Andree

GPG encrypted mail welcome, unless it's unsolicited commercial email.

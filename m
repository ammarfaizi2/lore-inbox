Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSGFF31>; Sat, 6 Jul 2002 01:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSGFF30>; Sat, 6 Jul 2002 01:29:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:6930 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317611AbSGFF3Z>; Sat, 6 Jul 2002 01:29:25 -0400
Date: Sat, 6 Jul 2002 02:31:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@zip.com.au>, <linux-mm@kvack.org>
Subject: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
Message-ID: <Pine.LNX.4.44L.0207060228460.8346-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Almost the same patch as before, except this one has had
a few hours of testing by Andrew Morton and two bugs have
been ironed out, most notably the truncate_complete_page()
race.  This patch is probably safe since Andrew got bored
when no new bugs showed up ...

If you have some time left this weekend and feel brave,
please test the patch which can be found at:

	http://surriel.com/patches/2.5/2.5.25-rmap-akpmtested

This patch is based on Craig Kulesa's minimal rmap patch
for 2.5.24, with a few changes:
- removed a few unrelated changes
- updated armv/rmap.h for new pagetable layout of linux/arm
- dropped per-zone pte_chain freelists, we want to make per-cpu
  ones for SMP scalability
- ported to 2.5.25 (PF_NOWARN instead of PF_RADIX_TREE)
- drop spelling and whitespace fixes (should be merged separately)
- fix truncate_complete_page race condition (akpm)

It should be mostly ready for being integrated into the 2.5 tree,
with the note that pte-highmem support still needs to be implemented
(some IBMers have been volunteered for this task, this functionality
can easily be added afterwards).

Right now this patch needs testing and careful scrutiny. If you can
find anything wrong with it, please let me know.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/



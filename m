Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266506AbRGDF5a>; Wed, 4 Jul 2001 01:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRGDF5V>; Wed, 4 Jul 2001 01:57:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56586 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266506AbRGDF5E>; Wed, 4 Jul 2001 01:57:04 -0400
Date: Wed, 4 Jul 2001 01:24:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: [PATCH] initial detailed VM statistics code
Message-ID: <Pine.LNX.4.21.0107040107320.3257-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Well, I've started working on VM stats code for 2.4. 

vmstat output: 

# r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
# 0  1  1 102624   1412    120  89472   90 9114   304  9160  336  1102  12 7 92

This is the already known part..

# launder launder_w ref_inact alloc_r kswapd_w krec_w kflush_w
#     33       11       147    1260       23    328      151

First, the global statistics:

launder: nr of page_launder() calls
launder_w: nr of times page_launder() started writing out pages
ref_inac: nr of refill_inactive_scan() calls
alloc_r: number of reschedules on __alloc_pages()
kswapd_w: kswapd wakeups
krec_w: kreclaimd wakeups
kflush_w: kflushd wakeups

# Zone fshort ishort   scan  clean  skipl  skipd launder  react rescue deact recfail
#    DMA      0    224   3915   1500    342   1406    531    153      0 452 636
# Normal      0      0  28073  12490   2451   9295   2678    676      0 2654     947

Then the perzone statistics:

fshort: per-zone free shortage
ishort: per-zone inactive shortage
scan: number of pages scanned by page_launder
clean: number of pages cleaned by page_launder
skipl: number of locked pages skipped by page_launder
skipd: number of unlocked but dirty pages skipped by page_launder
launder: number of pages laundered by page_launder
react: number of pages reactivated by page_launder
rescue: number of pages reactivated by reclaim_page
deat: number of pages deactivated by refill_inactive_scan
recfail: number of reclaim_page failures


The code: 

Patch against 2.4.6pre9:
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.6pre9/vmstats.patch

Patch against procps from Conectiva's srpm (which is not stock procps):
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.6pre9/procps.patch

And full vmstat.c so people don't need to get Conectiva's srpm:
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.6pre9/vmstat.c

The vmstat code is really crappy and new fields are painfull to add. If
anyone is willing to help me to write a decent vmstat, tell me. 

The hacked vmstat will coredump on a non-patched kernel.



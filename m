Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbRE0BgF>; Sat, 26 May 2001 21:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbRE0Bfz>; Sat, 26 May 2001 21:35:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40836 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262692AbRE0Bfr>;
	Sat, 26 May 2001 21:35:47 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15120.23023.903912.358739@pizda.ninka.net>
Date: Sat, 26 May 2001 18:35:43 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5aa1
In-Reply-To: <20010526193310.A1834@athlon.random>
In-Reply-To: <20010526193310.A1834@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > 00_eepro100-64bit-1
 > 
 > 	Fixes a 64bit bug that was generating false positives and memory
 > 	corruption.
 > 
 > 	(recommended)

Good spotting, I've put this into my tree ;-)

 > 00_eepro100-alpha-1
 > 
 > 	Possibly fix the eepro100 transmitter hang on alpha by doing atomic PIO
 > 	updates to avoid the clear_suspend to be lost.
 > 	
 > 	(recommended)

The correct fix is to create {set,clear,change}_bit{8,16,32}()
routines architectures may implement.  The comment there in eepro100.c
indicates the those defines are simply wrong for anything other than
x86, not just Alpha.

 > 00_ipv6-null-oops-1
 > 
 > 	Fixes null pointer oops.
 > 
 > 	(recommended)

Please delete this, a proper fix is in 2.4.5, and in fact your
added NULL test will never pass now :-)

 > 10_no-virtual-1
 > 
 > 	Avoids wasting tons of memory if highmem is not selected (like
 > 	in all the 64bit ports).
 > 
 > 	(nice to have)

I experimented with computing the address every time on sparc64 and
the performance actually went down slightly, it turned out it's
quicker to load from an in-cache page struct member than compute the
offset each time.

It's probably not an issue on ix86, but who knows.

I have no strong opinions about the other patches ;-)

Later,
David S. Miller
davem@redhat.com

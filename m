Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317531AbSGXU3F>; Wed, 24 Jul 2002 16:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSGXU3F>; Wed, 24 Jul 2002 16:29:05 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:19163 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S317531AbSGXU3D>; Wed, 24 Jul 2002 16:29:03 -0400
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
From: Steven Cole <elenstev@mesatop.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <1027434665.12588.78.camel@spc9.esa.lanl.gov>
References: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu> 
	<1027434665.12588.78.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Jul 2002 14:28:42 -0600
Message-Id: <1027542523.7518.108.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 08:31, I (Steven Cole) wrote:
> On Mon, 2002-07-22 at 16:36, Craig Kulesa wrote:
> > 
> > On Mon, 22 Jul 2002, William Lee Irwin III wrote:
> > 
> > > The pte_chain mempool was ridiculously huge and the use of mempool for
> > > this at all was in error.
> > 
> [snipped]
> > 
> > in dquot.c.  It'll be tested and fixed on the next go. :)
> 
> 1st the good news.  The 2.5.27-rmap-2b-dqcache patch fixed the compile
> problem with CONFIG_QUOTA=y.
> 
> Then, I patched in 2.5.27-rmap-3-slaballoc from Craig's site and the
> test machine got much further in the boot, but hung up here:
> 
> Starting cron daemon
> /etc/rc.d/rc3.d/S50inet: fork: Cannot allocate memory
> 
> Sorry, no further information was available.

I finally got some time for more testing, and I booted this very same
2.5.25-rmap-slablru kernel on the same machine, and this time it booted
just fine. Then I began to exercise the box a little by running dbench
with increasing numbers of clients.  At 28 clients, I got this:

(31069) open CLIENTS/CLIENT16/~DMTMP/WORDPRO/BENCHS1.PRN failed for handle 4148 (Cannot allocate memory)
(31070) nb_close: handle 4148 was not open
(31073) unlink CLIENTS/CLIENT16/~DMTMP/WORDPRO/BENCHS1.PRN failed (No such file or directory)

Right after starting 32 dbench clients, the box locked up, no longer
responding to the keyboard.  It did respond to pings, but nothing else.

This hardware does run other kernels successfully, most recently
2.4.19-rc3-ac3 and dbench 128 (load over 100).

Steven



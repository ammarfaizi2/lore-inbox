Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTJPQVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTJPQVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:21:48 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:55030 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263205AbTJPQVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:21:47 -0400
Date: Thu, 16 Oct 2003 10:20:20 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016102020.A7000@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Eli Billauer <eli_billauer@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F8E8101.70009@pobox.com>; from jgarzik@pobox.com on Thu, Oct 16, 2003 at 07:29:05AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2003  07:29 -0400, Jeff Garzik wrote:
> Eli Billauer wrote:
> > I suppose you're asking why having a /dev/frandom device at all. Why not 
> > let everyone write their own little random generator (based upon 
> > well-known C functions) whenever random data is needed.
> > 
> > There are plenty of handy things in the kernel, that could be done in 
> > userspace. /dev/zero is my favourite example, but I'm sure there are 
> > other cases where things were put in the kernel simply because people 
> > found them handy. Which is a good reason, if you ask me.
> 
> This is completely bogus logic.  I can use this (incorrect) argument to 
> similar push for applications doing bsearch(3) or qsort(3) via a system 
> call.
> 
> When the _implementation_ requires that a piece of code be in-kernel 
> (for performance or security, usually), it is.

Actually, there are several applications of low-cost RNG inside the kernel.

For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
the kernel.  The use of get_random_bytes() showed up near the top of
our profiles and we had to invent our own low-cost crappy PRNG instead (it's
good enough for the time being, but when we start working on real security
it won't be enough).

The tcp sequence numbers probably do not need to be crypto-secure (I could
of course be wrong on that ;-) and with GigE or 10GigE I imagine the number
of packets being sent would put a strain on the current random pool.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


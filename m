Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbULWPaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbULWPaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 10:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULWPaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 10:30:16 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29060 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261250AbULWPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 10:30:08 -0500
Subject: Re: Negative "ios_in_flight" in the 2.4 kernel
From: "M. Edward Borasky" <znmeb@cesmail.net>
Reply-To: znmeb@cesmail.net
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041223080806.GG12463@suse.de>
References: <1103691937.23157.14.camel@DreamGate>
	 <20041222111642.GD12463@suse.de> <1103728782.26340.34.camel@DreamGate>
	 <20041222155816.GF3088@logos.cnet>  <20041223080806.GG12463@suse.de>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 07:30:04 -0800
Message-Id: <1103815804.4063.33.camel@DreamGate>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-23 at 09:08 +0100, Jens Axboe wrote:
> > We could eliminate that possibility if you ran your tests with a single 
> > non-partitioned disk, but thats just a guess.
> 
> It would be nice to know if this was a vanilla kernel or patched in some
> way. The only recent bug in this area I remember was a bad merge in the
> SUSE tree with the io_request_lock scaling patch.

I have seen this with Red Hat 2.4.18 (from RH 8.0) kernels, Gentoo
2.4.25 and 2.4.26 kernels, on both single-disk and two-disk systems. Now
that I think of it, I've seen this on both single-processor and
multi-processor systems and with both SCSI and IDE drives. I have also
seen these systems run for quite a while without ios_in_flight going
negative. And I've never seen ios_in_flight lower than -1 or higher than
0 on an idle system. So my conclusion is that an extra downcount is
fairly rare.

I saw a very similar bug listed in the LKML about a year ago. For
example, see

http://search.luky.org/linux-kernel.2004/msg00025.html

and

http://search.luky.org/linux-kernel.2004/msg03278.html

I think I'll try rebooting the two-disk box (which is easier to get one
truly idle disk on) and running bonnie++ periodically to see if I can
get steady-state ios_in_flight values other than -1 and 0 on an idle
system (between bonnie++ runs). I can set up "oprofile" on the Gentoo
boxes if that will help.

One other note: all of these systems when "idle" have a small amount of
write activity going on. The Red Hat boxes are using ext3 filesystems
and the Gentoo systems are using reiserfs. Is constant low-level writing
to be expected with journaling?


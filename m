Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTJQTY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTJQTY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:24:27 -0400
Received: from unthought.net ([212.97.129.88]:7598 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263598AbTJQTYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:24:21 -0400
Date: Fri, 17 Oct 2003 21:24:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031017192419.GG8711@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xu167kbcw.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 07:44:31PM +0200, Måns Rullgård wrote:
...
> 
> What about the RAID controllers in the $400 category?  Surely, they
> must be doing something better than the $50 fakeraid controllers.

The RAID controllers in the $400 category are exactly the ones who
include (inferior) processors, and add an extra layer in the 'chain of
command'.

The inexpensive 'fakeraid' controllers include some form of SW RAID in
their driver, and could therefore perform as well as Linux SW RAID (if
the driver's RAID code is as clever and efficient as the Linux SW RAID
code - which it may not be).

Ironic, maybe  ;)

I have never tried using one of the 'fakeraid' controllers, so I can't
speak for their actual real-world performance.  They could include a
crap IDE controller, or they could have crap drivers - both could give
poor performance.

Could, would, should, don't know...

However, the "hardware RAID" controllers that were discussed here would
be the ones in the $400->$(obscene) price range.

Now that I'm posting anyway - I thought of a plus for the HW RAID
controllers (hey, they're way behind on the scoreboard so far, so I
might as well be a gentleman and give them a point or two):
*) Battery backed write cache

This will allow the controller to say 'ok I'm done with your sync()',
way before the data actually reaches the disk platters.  For some
workloads this can be a big win.  For some odd reason, it seems that
'most' (read: all that I could find) HW RAID controllers are unable to
control more than 256 MB of memory - which is odd. That amound of memory
is almost so low that it defeats the purpose of having it in the first
place.  But again, some workloads may well benefit.  And this is
something you just can't do with SW RAID (at least not before someone
implements support for an NVRAM buffer store in the Linux I/O layer).

While on that topic: SDRAM PCI cards with battery backup can be had
relatively cheap up to at least a few gigabytes.  It'd be pretty cool to
have the kernel recognize that for buffer storage. I could see the fun
in doing half a million random writes and a sync(), and having the
system tell me it's done the microsecond I issue the sync().

Enough with the daydreaming already  ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

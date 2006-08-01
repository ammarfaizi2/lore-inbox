Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWHABCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWHABCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHABCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:02:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:7066 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030371AbWHABCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:02:19 -0400
X-Authenticated: #428038
Date: Tue, 1 Aug 2006 03:02:15 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: David Lang <dlang@digitalinsight.com>,
       Matthias Andree <matthias.andree@gmx.de>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060801010215.GA24946@merlin.emma.line.org>
Mail-Followup-To: Nate Diller <nate.diller@gmail.com>,
	David Lang <dlang@digitalinsight.com>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
	reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
	tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <20060731175958.1626513b.reiser4@blinkenlights.ch> <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch> <44CE7C31.5090402@gmx.de> <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Nate Diller wrote:

> this is only a limitation for filesystems which do in-place data and
> metadata updates.  this is why i mentioned the similarities to log
> file systems (see rosenblum and ousterhout, 1991).  they observed an
> order-of-magnitude increase in performance for such workloads on their
> system.

It's well known that transactions that would thrash on UFS or ext2fs may
have quieter access patterns with shorter strokes can benefit from
logging, data journaling, whatever else turns seeks into serial writes.
And then, the other question with wandering logs (to avoid double
writes) and such, you start wondering how much fragmentation you get as
the price to pay for avoiding seeks and double writes at the same time.
TANSTAAFL, or how long the system can sustain such access patterns,
particularly if it gets under memory pressure and must move. Even with
lazy allocation and other optimizations, I question the validity of
3000/s or faster transaction frequencies. Even the 500 on ext3 are
suspect, particularly with 7200/min (s)ATA crap. This sounds pretty much
like the drive doing its best to shuffle blocks around in its 8 MB cache
and lazily writing back.

sdparm --clear=WCE /dev/sda   # please.

-- 
Matthias Andree

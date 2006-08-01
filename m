Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWHAJJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWHAJJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWHAJJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:09:53 -0400
Received: from mail.gmx.de ([213.165.64.21]:29375 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751341AbWHAJJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:09:52 -0400
X-Authenticated: #428038
Date: Tue, 1 Aug 2006 11:09:47 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Cc: Matthias Andree <matthias.andree@gmx.de>, nate.diller@gmail.com,
       dlang@digitalinsight.com, vonbrand@inf.utfsm.cl, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060801090947.GA2974@merlin.emma.line.org>
Mail-Followup-To: Adrian Ulrich <reiser4@blinkenlights.ch>,
	nate.diller@gmail.com, dlang@digitalinsight.com,
	vonbrand@inf.utfsm.cl, ipso@snappymail.ca, reiser@namesys.com,
	lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch> <44CE7C31.5090402@gmx.de> <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> <20060801010215.GA24946@merlin.emma.line.org> <20060801095141.5ec0b479.reiser4@blinkenlights.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801095141.5ec0b479.reiser4@blinkenlights.ch>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich schrieb am 2006-08-01:

> > suspect, particularly with 7200/min (s)ATA crap. 
> 
> Quoting myself (again):
> >> A quick'n'dirty ZFS-vs-UFS-vs-Reiser3-vs-Reiser4-vs-Ext3 'benchmark'
> 
> Yeah, the test ran on a single SATA-Harddisk (quick'n'dirty).
> I'm so sorry but i don't have access to a $$$ Raid-System at home. 

I'm not asking for you to perform testing on a $$$$ RAID system with
SCSI or SAS, but I consider the obtained data (I am focussing on
transactions per unit of time) highly suspicious, and suspect write
caches might have contributed their share - I haven't seen a drive that
shipped with write cache disabled in the past years.

> > sdparm --clear=WCE /dev/sda   # please.
> 
> How about using /dev/emcpower* for the next benchmark?

No, it is valid to run the test on commodity hardware, but if you (or
the benchmark rather) is claiming "transactions", I tend to think
"ACID", and I highly doubt any 200 GB SATA drive manages 3000
synchronous writes per second without causing either serious
fragmentation or background block moving.

This is a figure I'd expect for synchronous random access to RAM disks
that have no seek and rotational latencies (and research for hybrid
disks w/ flash or other nonvolatile fast random access media to cache
actual rotating magnetic plattern access is going on elsewhere).

I didn't mean to say your particular drive were crap, but 200GB SATA
drives are low end, like it or not -- still, I have one in my home
computer because these Samsung SP2004C are so nicely quiet.

> I mighty be able to re-run it in a few weeks if people are interested
> and if i receive constructive suggestions (= Postmark parameters,
> mkfs options, etc..)

I don't know Postmark, I did suggest to turn the write cache off. If
your systems uses hdparm -W0 /dev/sda instead, go ahead. But you're
right to collect and evaluate suggestions first if you don't want to run
a new benchmark every day :)

-- 
Matthias Andree

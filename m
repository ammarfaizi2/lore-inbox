Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264017AbTKJR0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbTKJR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:26:17 -0500
Received: from kokytos.rz.informatik.uni-muenchen.de ([141.84.214.13]:6034
	"EHLO kokytos.rz.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S264017AbTKJR0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:26:15 -0500
Date: Mon, 10 Nov 2003 18:26:13 +0100
From: "Oliver M. Bolzer" <oliver@gol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Success with  Promise FastTrak S150 TX4 (Re: [BK PATCHES] libata fixes)
Message-ID: <20031110172613.GA2962@magi.fakeroot.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031108172621.GA8041@gtf.org> <20031110095248.GA20497@magi.fakeroot.net> <3FAFBC28.5000600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFBC28.5000600@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:26:16AM -0500, Jeff Garzik <jgarzik@pobox.com> wrote...
 
> ># A first quick run of bonnie++ seems to show 2.6.0-test9+libata several
> ># %s slower then 2.4.22+ft3xx, but that might be related to differences
> ># between 2.4 and 2.6.
> 
> One possibility is that queueing is not yet enabled in my sata_promise 
> driver.  Several of the SATA drivers support having multiple commands 
> outstanding per driver (tagged command queueing), but I need to do a bit 
> more work before I can enable queueing in the core.

I disabled /dev/mdX Software-RAID5 on two of the boxes that have the
hardware (got 8 of them) and did some preliminary benchmarking using
bonnie++ 1.02b. The hardware is P4-2.4GHz, 1GB RAM (highmem-enabled) wich
4 Maxtor SATA-drives with 200GBs each. The partitions I ran the tests
on are 186GB large.

2.4.22 + Promise ft3xx
silo4:/dev/sda3

Version 1.02b       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
silo4.rz.informa 2G 27330  95 62522  19 22619   6 29056  98 56311   6 159.7   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  3007  98 +++++ +++ +++++ +++  3087  99 +++++ +++  9173 100
silo4,2G,27330,95,62522,19,22619,6,29056,98,56311,6,159.7,0,16,3007,98,+++++,+++,+++++,+++,3087,99,+++++,+++,9173,100

==========
2.4.22-bk48 + 2.4.22-bk48-libata1
silo5:/dev/sda3

Version 1.02b       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
silo5.rz.informa 2G 28068  96 61698  18 23174   5 24372  77 56009   6 175.1   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  2986  97 +++++ +++ +++++ +++  3136  99 +++++ +++  9867  98
silo5,2G,28068,96,61698,18,23174,5,24372,77,56009,6,175.1,0,16,2986,97,+++++,+++,+++++,+++,3136,99,+++++,+++,9867,98


The performance differences are not that big that they would really
matter. One is better at one direction while the other is better at the
other direction.

I am REALLY happy that a free-as-in-freedom driver exist for the hardware
that has a much more certain future thant a
looks-like-GPL-on-the-first-look-but-one--.o-has-no-source driver. And
the libata code was really nice to read and follow, even though I knew
almost nothing about disk driver. THANK YOU!

-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF

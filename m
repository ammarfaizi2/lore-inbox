Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTLPVG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTLPVG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:06:58 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:22771 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S262564AbTLPVGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:06:55 -0500
Date: Tue, 16 Dec 2003 16:11:31 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031216161131.A6197@mail.kroptech.com>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031216040156.GJ12726@pegasys.ws>; from jw@pegasys.ws on Mon, Dec 15, 2003 at 08:01:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 08:01:56PM -0800, jw schultz wrote:
> On Mon, Dec 15, 2003 at 02:34:54PM +0100, Witold Krecicki wrote:
> > Those are results of hdparm -tT on drives:
> > <cite>
> > /dev/md/1:
> >  Timing buffer-cache reads:   128 MB in  0.40 seconds =323.28 MB/sec
> >  Timing buffered disk reads:  64 MB in  1.75 seconds = 36.47 MB/sec
> > /dev/sda:
> >  Timing buffer-cache reads:   128 MB in  0.41 seconds =309.23 MB/sec
> >  Timing buffered disk reads:  64 MB in  1.46 seconds = 43.87 MB/sec
> > /dev/sdb:
> >  Timing buffer-cache reads:   128 MB in  0.41 seconds =315.32 MB/sec
> >  Timing buffered disk reads:  64 MB in  1.23 seconds = 52.04 MB/sec
> > </cite>
> 
> No Linux [R]AID improves sequential performance.  How would
> reading 65KB from two disks in alternation be faster than
> reading continuously from one disk?

Never say never:

/dev/sda:
 Timing buffer-cache reads:   128 MB in  3.34 seconds = 38.38 MB/sec
 Timing buffered disk reads:  64 MB in  8.60 seconds =  7.44 MB/sec
/dev/sdb:
 Timing buffer-cache reads:   128 MB in  3.40 seconds = 37.64 MB/sec
 Timing buffered disk reads:  64 MB in  8.60 seconds =  7.44 MB/sec

<...plus four more just like them...>

/dev/md0:
 Timing buffer-cache reads:   128 MB in  3.35 seconds = 38.17 MB/sec
 Timing buffered disk reads:  64 MB in  4.05 seconds = 15.79 MB/sec

md0 is a simple RAID0 of all six disks.

Yes, these disks are dirt slow to begin with (Andrew Morton once
mentioned he had pencils that wrote faster than my disks) but apparently
md manages to get some parallelism going, even for sequential reads.

(This is 2.6.0-test11-bk8, FWIW.)

--Adam


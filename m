Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVBQXOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVBQXOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBQXMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:12:13 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:22434 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261226AbVBQXKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:10:39 -0500
Date: Fri, 18 Feb 2005 00:10:48 +0100
From: Tino Keitel <tino.keitel@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
Message-ID: <20050217231048.GA4363@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1108301794.9280.18.camel@localhost.localdomain> <20050213142635.GA2035@animx.eu.org> <20050214085320.GA4910@dose.home.local> <1108376734.9495.8.camel@localhost.localdomain> <20050214105332.GA7163@dose.home.local> <1108379351.9495.22.camel@localhost.localdomain> <20050214111819.GA7691@dose.home.local> <1108590900.7407.11.camel@localhost.localdomain> <1108592965.7407.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108592965.7407.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 23:29:24 +0100, Droebbel wrote:
> On Mi, 2005-02-16 at 22:55 +0100, Droebbel wrote:
> >Some new information:
> >
> >2.6.7 is ok, 2.6.7-mm2 is not ok, 2.6.7 with just the linus-patch from
> >mm2 is ok, 2.6.7 with linus.patch from mm3 isn't.
> >So I took some of the patches from the broken-out mm2 and tested them
> >seperately.
> >
> >The vmscan-dont-reclaim-too-many-pages.patch led to the said reduction
> >of writing speed. I reverse-applied it to 2.6.8.1, where it seems to
> >solve the problem.
> 
> Sorry, have to correct that: it seemed to help at my tests with dd
> (write 1G of zeroes to a file). Copying a file with mc still shows
> around 1.4MB/s. Could be worse, but is definitely not ok. It *is* better
> with 2.6.7.

Here are some numbers with my setup. I always wrote 1 GB of data to the
same DVD-RAM disc (EMTEC), to the device directly and to a fresh ext2
on
the disc.

kernel 2.6.10:

$ time { sudo dd if=/dev/zero of=bigfile bs=64k count=16000 ; sync ; }

real    32m5.025s

$ time {sudo dd if=/dev/zero of=/dev/cdrom bs=64k count=16000 ; sync ;}

real    29m41.980s

kernel 2.6.7:

$ time { sudo dd if=/dev/zero of=bigfile bs=64k count=16000 ; sync ; }

real    13m23.688s

$ time {sudo dd if=/dev/zero of=/dev/cdrom bs=64k count=16000 ; sync ;}

real    13m14.609s

Regards,
Tino

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274145AbRISTaO>; Wed, 19 Sep 2001 15:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274148AbRISTaE>; Wed, 19 Sep 2001 15:30:04 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27387 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274145AbRIST3x>; Wed, 19 Sep 2001 15:29:53 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 13:29:35 -0600
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: Fabian Arias <dewback@vtr.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
Message-ID: <20010919132935.M14526@turbolinux.com>
Mail-Followup-To: Wayne Whitney <whitney@math.berkeley.edu>,
	Fabian Arias <dewback@vtr.net>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109191053400.1244-100000@portland.hansa.lan> <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl> <200109191904.f8JJ40001476@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109191904.f8JJ40001476@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2001  12:04 -0700, Wayne Whitney wrote:
> I also have reiserfs mounts from /etc/fstab failing in 2.4.9-ac12, so
> I straced the mount process.  With options "defaults" in /etc/fstab,
> "mount /usr/local" does:
> 
>   mount("/dev/hde8", "/usr/local", "reiserfs", 0xc0ed0000, 0x80597a8) = -1 EINVAL (Invalid argument)

Could you run gdb on your mount and show us what *data contains at this
point (last parameter).  According to man(8) "defaults" expands to
"rw,suid,dev,exec,auto,nouser,async".  You could also try putting
all of these in /etc/fstab explicitly and remove them one at a time
until we find which one it is complaining about.  Either mount(8)
shouldn't be appending this option to the mount data, or reiserfs
needs to parse it in the kernel.

> While "mount /dev/hde8 /usr/local" gives:
> 
>   mount("/dev/hde8", "/usr/local", "reiserfs", 0xc0ed0000, 0) = 0

Works OK, no option data passed.

> But with the options "notail" in /etc/fstab, "mount /usr/local" does:
> 
>   mount("/dev/hde8", "/usr/local", "reiserfs", 0xc0ed0000, 0x806d3e0) = 0

Works OK, has "notail" but not any other options from "defaults".

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


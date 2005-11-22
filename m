Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVKVKEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVKVKEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVKVKEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:04:06 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:17270 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964862AbVKVKEE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:04:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C3U6nGq7jthYabWzUCqheqQDbe1sA8JYUdKytYmwHVxzV1+gRaGktgxLw2DK95PZgOfkee3MoyG4k40j0b7T0MK5XlkEg6G/XMebFYrMb1k5+fQ5mygyy8l8uBaj/S0hvBPjXpTMMTVyE8qBUdSiT+OEZX3D7a71G9LVSwIH7lc=
Message-ID: <4ad99e050511220204y70f998c1y1a89b059826110db@mail.gmail.com>
Date: Tue, 22 Nov 2005 11:04:03 +0100
From: Lars Roland <lroland@gmail.com>
To: Neil Brown <neilb@suse.de>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17282.17053.19267.253430@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
	 <17282.17053.19267.253430@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Neil Brown <neilb@suse.de> wrote:
> On Monday November 21, lroland@gmail.com wrote:
> > I have created a stripe across two 500Gb disks located on separate IDE
> > channels using:
> >
> > mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd
> >
> > the performance is awful on both kernel 2.6.12.5 and 2.6.14.2 (even
> > with hdparm and blockdev tuning), both bonnie++ and hdparm (included
> > below) shows a single disk operating faster than the stripe:
> >
> > ----
> > dkstorage01:~# hdparm -t /dev/md0
> > /dev/md0:
> >  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.47 MB/sec
> >
> > dkstorage02:~# hdparm -t /dev/hdc1
> > /dev/hdc1:
> > Timing buffered disk reads:  184 MB in  3.02 seconds =  60.93 MB/sec
> > ----
>
> Could you try hdparm tests on the two drives in parallel?
>    hdparm -t /dev/hdb & hdparm -t /dev/hdd
>
> It could be that the controller doesn't handle parallel traffic very
> well.
>

hmm I should of cause have thought of this earlier - it does indeed
seam that the controller does not handle parallel traffic very well

-----------
dkstorage01:~# hdparm -t /dev/hdb
/dev/hdb:
 Timing buffered disk reads:  112 MB in  3.02 seconds =  37.09 MB/sec

dkstorage01:~# hdparm -t /dev/hdd
/dev/hdd:
 Timing buffered disk reads:  108 MB in  3.02 seconds =  35.76 MB/sec
-----------

Bonnie test shows the same picture.

> raid0 has essentially 0 cpu overhead.  It would be maybe a couple of
> hundred instructions which would be lost in the noise.  It just
> figures out which drive each request should go to, and directs it
> there.

Yeah so it is properly just a poor controller.


--
Lars Roland

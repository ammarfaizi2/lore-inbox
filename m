Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030743AbWJKBqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030743AbWJKBqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 21:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030742AbWJKBqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 21:46:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:36432 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030743AbWJKBqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 21:46:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GEs/+Q9ZtrlhteZ1G9kdHVaUn00QpIm9Mzw/PnIB3Ep81B3aD7rHpOmMF5JnsV4TmHmVVn4yHFxRORMRfKsh2P8gWe5GDqRinvZB08zG6Nou6CfWa9UmOgxJTOlL8B/anXrm7z3kTcL/9RLbPALFeNNi8fHsA7ZBo3HsMM1qdKQ=
Message-ID: <e9c3a7c20610101846o4b61790cwa7088e5a8cf8e65a@mail.gmail.com>
Date: Tue, 10 Oct 2006 18:46:08 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Jakob Oestergaard" <jakob@unthought.net>
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
In-Reply-To: <20060914074248.GD23492@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <20060913071512.GA23492@unthought.net>
	 <e9c3a7c20609131217q145fb234q36f70b23f1acf950@mail.gmail.com>
	 <20060914074248.GD23492@unthought.net>
X-Google-Sender-Auth: fb390945ff6f63a7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Jakob Oestergaard <jakob@unthought.net> wrote:
> On Wed, Sep 13, 2006 at 12:17:55PM -0700, Dan Williams wrote:
> ...
> > >Out of curiosity; how does accelerated compare to non-accelerated?
> >
> > One quick example:
> > 4-disk SATA array rebuild on iop321 without acceleration - 'top'
> > reports md0_resync and md0_raid5 dueling for the CPU each at ~50%
> > utilization.
> >
> > With acceleration - 'top' reports md0_resync cpu utilization at ~90%
> > with the rest split between md0_raid5 and md0_raid5_ops.
> >
> > The sync speed reported by /proc/mdstat is ~40% higher in the accelerated
> > case.
>
> Ok, nice :)
>
> >
> > That being said, array resync is a special case, so your mileage may
> > vary with other applications.
>
> Every-day usage I/O performance data would be nice indeed :)
>
> > I will put together some data from bonnie++, iozone, maybe contest,
> > and post it on SourceForge.
>
> Great!
>
I have posted some Iozone data and graphs showing the performance
impact of the patches across the three iop processors iop321, iop331,
and iop341.  The general take away from the data is that using dma
engines extends the region that Iozone calls the "buffer cache
effect".  Write performance benefited the most as expected, but read
performance showed some modest gains as well.  There are some regions
(smaller file size and record length) that show a performance
disadvantage but it is typically less than 5%.

The graphs map the relative performance multiplier that the raid
patches generate ('2.6.18-rc6 performance' x 'performance multiplier'
= '2.6.18-rc6-raid performance') .  A value of '1' designates equal
performance.  The large cliff that drops to zero is a "not measured"
region, i.e. the record length is larger than the file size.  Iozone
outputs to Excel, but I have also made pdf's of the graphs available.
Note: Openoffice-calc can view the data but it does not support the 3D
surface graphs that Iozone uses.

Excel:
http://prdownloads.sourceforge.net/xscaleiop/iozone_raid_accel.xls?download

PDF Graphs:
http://prdownloads.sourceforge.net/xscaleiop/iop-iozone-graphs-20061010.tar.bz2?download

Regards,
Dan

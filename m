Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUIAHww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUIAHww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUIAHww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:52:52 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:39861 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S268088AbUIAHwt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:52:49 -0400
Date: Wed, 01 Sep 2004 07:52:46 +0000
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com>
	<20040804120633.4dca57b3.akpm@osdl.org> <411ABF85.2080200@techsource.com>
	<41336CB1.6030105@techsource.com> <cgvpb4$ljq$1@news.cistron.nl>
	<4134FFC3.50409@techsource.com>
In-Reply-To: <4134FFC3.50409@techsource.com> (from miller@techsource.com on
	Wed Sep  1 00:46:27 2004)
X-Mailer: Balsa 2.2.3
Message-Id: <1094025166l.22433l.1l@drinkel.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2004 00:46:27, Timothy Miller wrote:
> Miquel van Smoorenburg wrote:
> > In article <41336CB1.6030105@techsource.com>,
> > Timothy Miller  <miller@techsource.com> wrote:
> > 
> >>Timothy Miller wrote:
> >>
> >>>Hey, that rings a bell.  I have a 3ware 7000-2 controller with two 
> >>>WD1200JB drives in RAID1.  I find that if I dd from the disk, I get 
> >>>exactly the read throughput that is the max for the drives (47MB/sec). 
> >>>However, if I do a WRITE test, the performance is miserable.
> > 
> > Try setting /sys/block/sda/queue/nr_requests to twice the number
> > in /sys/block/sda/device/queue_depth
> 
> This will improve write performance?

You won't know before you try it ofcourse. It helps on my 85xx controllers.
The problem is that the internal queue size of some 3ware controllers
(queue_depth) is larger than the I/O schedulers nr_requests so that
the I/O scheduler doesn't get much chance to properly order and merge
the requests.

I've sent patches to 3ware a couple of times to make queue_depth
writable so that you can tune that as well, but they were refused
for no good reason AFAICS. Very unfortunate - if you have 8 JBOD
disks attached, you want to set queue_depth for each of them to
(max_controller_queue_depth / 8) to prevent one disk from starving
the other ones, but oh well.

> And if this helps, how do I make 
> it permanent?

Can't say, depends on your distribution. For recent Debian at
least you can use /etc/sysctl.conf

Mike.


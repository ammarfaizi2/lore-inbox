Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUIZBFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUIZBFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269468AbUIZBFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:05:34 -0400
Received: from web40728.mail.yahoo.com ([66.218.92.66]:6330 "HELO
	web40728.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269467AbUIZBFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:05:22 -0400
Message-ID: <20040926010521.13625.qmail@web40728.mail.yahoo.com>
Date: Sat, 25 Sep 2004 18:05:21 -0700 (PDT)
From: Timothy Miller <theosib@yahoo.com>
Subject: Re: [Fwd: Re: HIGHMEM4G config for 1GB RAM on desktop?]
To: linux-kernel@vger.kernel.org
In-Reply-To: <4151E181.80500@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -------- Original Message --------
> Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
> Date: Wed, 01 Sep 2004 07:52:46 +0000
> From: Miquel van Smoorenburg <miquels@cistron.nl>
> To: Timothy Miller <miller@techsource.com>
> CC: linux-kernel@vger.kernel.org
> References: <200408021602.34320.swsnyder@insightbb.com> 
> <20040804120633.4dca57b3.akpm@osdl.org> 
> <411ABF85.2080200@techsource.com>	<41336CB1.6030105@techsource.com> 
> <cgvpb4$ljq$1@news.cistron.nl>	<4134FFC3.50409@techsource.com>
> 
> On Wed, 01 Sep 2004 00:46:27, Timothy Miller wrote:
> > Miquel van Smoorenburg wrote:
> > > In article <41336CB1.6030105@techsource.com>,
> > > Timothy Miller  <miller@techsource.com> wrote:
> > > 
> > >>Timothy Miller wrote:
> > >>
> > >>>Hey, that rings a bell.  I have a 3ware 7000-2 controller with
> two 
> > >>>WD1200JB drives in RAID1.  I find that if I dd from the disk, I
> get 
> > >>>exactly the read throughput that is the max for the drives
> (47MB/sec). 
> > >>>However, if I do a WRITE test, the performance is miserable.
> > > 
> > > Try setting /sys/block/sda/queue/nr_requests to twice the number
> > > in /sys/block/sda/device/queue_depth
> > 
> > This will improve write performance?
> 
> You won't know before you try it ofcourse. It helps on my 85xx
> controllers.
> The problem is that the internal queue size of some 3ware controllers
> (queue_depth) is larger than the I/O schedulers nr_requests so that
> the I/O scheduler doesn't get much chance to properly order and merge
> the requests.
> 
> I've sent patches to 3ware a couple of times to make queue_depth
> writable so that you can tune that as well, but they were refused
> for no good reason AFAICS. Very unfortunate - if you have 8 JBOD
> disks attached, you want to set queue_depth for each of them to
> (max_controller_queue_depth / 8) to prevent one disk from starving
> the other ones, but oh well.
> 
> > And if this helps, how do I make 
> > it permanent?
> 
> Can't say, depends on your distribution. For recent Debian at
> least you can use /etc/sysctl.conf
> 


I tried the suggestions above of setting
/sys/block/sda/queue/nr_requests to twice the number in
/sys/block/sda/device/queue_depth.

It brought up my write performance from 12.5MB/sec to 13.2MB/sec.  An
improvement, but not much of one, and definately far less than the
capability of the drive which I have measured to be around 36MB/sec.

(I tested each drive of my RAID1 separately on the built-in IDE
controller.  What I found was that the 3ware was slighly faster on
reads, but WAY slower on writes, compared to the drives individually on
the IDE controller.)



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVLBJw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVLBJw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 04:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVLBJw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 04:52:59 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:53406 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932549AbVLBJw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 04:52:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Date: Fri, 2 Dec 2005 10:54:02 +0100
User-Agent: KMail/1.8.3
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20051201173649.GA22168@hexapodia.org> <200512012242.44995.rjw@sisk.pl> <20051202005514.GA1770@elf.ucw.cz>
In-Reply-To: <20051202005514.GA1770@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512021054.03245.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 2 of December 2005 01:55, Pavel Machek wrote:
> > > My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> > > 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> > > successful suspend/resume cycles.  But now that I'm running
> > > 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:
> > 
> > Thanks a lot for the report.
> > 
> > The problem is apparently caused by my recent patch intended to speed up
> > suspend.  Could you please apply the appended debug patch, try to reproduce
> > the problem and send full dmesg output back to me?
> > 
> > Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
> > ===================================================================
> > --- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-01 22:13:17.000000000 +0100
> > +++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-01 22:24:56.000000000 +0100
> > @@ -635,12 +635,18 @@
> >  	printk("Shrinking memory...  ");
> >  	do {
> >  #ifdef FAST_FREE
> > -		tmp = count_data_pages() + count_highmem_pages();
> > +		tmp = count_data_pages();
> > +		printk("Data pages: %ld\n", tmp);
> > +		tmp += count_highmem_pages();
> 
> You need at least count_data_pages() + 2*count_highmem_pages() free
> pages (in lowmem).

Do you mean a separate page is needed for each kmalloc() in
save_highmem_zone()?

Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

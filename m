Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVA0I22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVA0I22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 03:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVA0I22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 03:28:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1294 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262291AbVA0I2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 03:28:22 -0500
Date: Thu, 27 Jan 2005 08:28:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050127082809.A20510@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, alexn@dsv.su.se, kas@fi.muni.cz,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050125193207.B30094@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 25, 2005 at 07:32:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 07:32:07PM +0000, Russell King wrote:
> On Mon, Jan 24, 2005 at 11:48:53AM +0000, Russell King wrote:
> > On Sun, Jan 23, 2005 at 08:03:15PM +0000, Russell King wrote:
> > > I think I may be seeing something odd here, maybe a possible memory leak.
> > > The only problem I have is wondering whether I'm actually comparing like
> > > with like.  Maybe some networking people can provide a hint?
> > > 
> > > Below is gathered from 2.6.11-rc1.
> > > 
> > > bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> > > 24
> > > ip_dst_cache         669    885    256   15    1
> > > 
> > > I'm fairly positive when I rebooted the machine a couple of days ago,
> > > ip_dst_cache was significantly smaller for the same number of lines in
> > > /proc/net/rt_cache.
> > 
> > FYI, today it looks like this:
> > 
> > bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
> > 26
> > ip_dst_cache         820   1065    256   15    1 
> > 
> > So the dst cache seems to have grown by 151 in 16 hours...  I'll continue
> > monitoring and providing updates.
> 
> Tonights update:
> 50
> ip_dst_cache        1024   1245    256   15    1
> 
> As you can see, the dst cache is consistently growing by about 200
> entries per day.  Given this, I predict that the box will fall over
> due to "dst cache overflow" in roughly 35 days.

This mornings magic numbers are:

3
ip_dst_cache        1292   1485    256   15    1

Is no one interested in the fact that the DST cache is leaking and
eventually takes out machines?  I've had virtually zero interest in
this problem so far.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

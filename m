Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbTC2MGj>; Sat, 29 Mar 2003 07:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263408AbTC2MGi>; Sat, 29 Mar 2003 07:06:38 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:59315 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S263404AbTC2MGi>;
	Sat, 29 Mar 2003 07:06:38 -0500
Date: Sat, 29 Mar 2003 13:17:55 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andi Kleen <ak@suse.de>, netdev@oss.sgi.com
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: NIC renaming does not rename /proc/sys/net/ipv4 Was: Re: NICs trading places ?
Message-ID: <20030329121755.GA17169@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Andi Kleen <ak@suse.de>,
	netdev@oss.sgi.com, Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20030328221037.GB25846@suse.de.suse.lists.linux.kernel> <p73isu2zsmi.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73isu2zsmi.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 29, 2003 at 05:47:17AM +0100, Andi Kleen wrote:
> Dave Jones <davej@codemonkey.org.uk> writes:
> 
> > I just upgraded a box with 2 NICs in it to 2.5.66, and found
> > that what was eth0 in 2.4 is now eth1, and vice versa.
> > Is this phenomenon intentional ? documented ?
> 
> Just assign mac addresses to names and run nameif early in boot.

A slight problem with that is that not all parts of /proc/sys get renamed
this way:

snapcount:/proc/sys/net/ipv4/conf# ifconfig lo down
snapcount:/proc/sys/net/ipv4/conf# ip link set name lo0 lo
snapcount:/proc/sys/net/ipv4/conf# ls -l
total 0
dr-xr-xr-x    2 root     root            0 Mar 29 13:16 all
dr-xr-xr-x    2 root     root            0 Mar 29 13:16 default
dr-xr-xr-x    2 root     root            0 Mar 29 13:16 eth0
dr-xr-xr-x    2 root     root            0 Mar 29 13:16 lo

Which can be very confusing. This problem exists in both 2.5 and 2.4.

Regards,

bert


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWBDNbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWBDNbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWBDNbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:31:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:12998 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932277AbWBDNbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:31:03 -0500
Date: Sat, 4 Feb 2006 12:52:17 +0100
From: Holger Eitzenberger <holger@my-eitzenberger.de>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, netdev@vger.kernel.org
Subject: Re: Linux 2.6.15.2
Message-ID: <20060204115217.GA5302@kruemel.my-eitzenberger.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
	linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
	netdev@vger.kernel.org
References: <20060131070642.GA25015@kroah.com> <20060130233427.5e7912ae.akpm@osdl.org> <20060203120925.GA4393@kruemel.my-eitzenberger.de> <20060203111414.7026f46f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203111414.7026f46f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 11:14:14AM -0800, Andrew Morton wrote:

> http://www.mail-archive.com/netdev@vger.kernel.org/msg06355.html

> > A look into /proc/sys/net/ipv4/tcp_mem showed that that the values in
> > there were way to high.  I hope that a reduction of these values will
> > help (not done yet).

> Sounds different.  Please test a more recent kernel and if the problem is
> still there, send a report to linux-kernel and cc netdev@vger.kernel.org. 
> Include the contents of /proc/meminfo and /proc/slabinfo.  Thanks.

I solved the issue.

Recent kernels have alloc_large_system_hash() exactly for that, and
tcp_init() uses it.  It has nr_all_pages and nr_kernel_pages to
determine the actual size of usable RAM, whereas 2.6.10 just uses
num_physpages.  That's the reason why the values in tcp_mem are way
too high on machines with 3-4 Gig RAM.

Thanks.  /holger


-- 
ICQ 2882018 ++ Jabber: octavian@amessage.de ++

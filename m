Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUD2QvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUD2QvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUD2QvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:51:19 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:2662 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264882AbUD2QvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:51:17 -0400
Date: Thu, 29 Apr 2004 11:51:16 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Singer <elf@buici.com>, riel@redhat.com, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429165116.GA24033@hexapodia.org>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com> <20040428201924.719dfb68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428201924.719dfb68.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 08:19:24PM -0700, Andrew Morton wrote:
> What you discuss above is just an implementation detail.  Forget it.  What
> are the requirements?  Thus far I've seen
> 
> a) updatedb causes cache reclaim
> 
> b) updatedb causes swapout
> 
> c) prefer that openoffice/mozilla not get paged out when there's heavy
>    pagecache demand.
> 
> For a) we don't really have a solution.  Some have been proposed but they
> could have serious downsides.
> 
> For b) and c) we can tune the pageout-vs-cache reclaim tendency with
> /proc/sys/vm/swappiness, only nobody seems to know that.
> 
> What else is there?

What I want is for purely sequential workloads which far exceed cache
size (dd, updatedb, tar czf /backup/home.nightly.tar.gz /home) to avoid
thrashing my entire desktop out of memory.  I DON'T CARE if the tar
completed in 45 minutes rather than 80.  (It wouldn't, anyways, because
it only needs about 5 MB of cache to get every bit of the speedup it was
going to get.)  But the additional latency when I un-xlock in the
morning is annoying, and there is no benefit.

For a more useful example, ideally I *should not be able to tell* that
"dd if=/hde1 of=/hdf1" is running. [1]  There is *no* benefit to cacheing
more than about 2 pages, under this workload.  But with current kernels,
IME, that workload results in a gargantuan buffer cache and lots of
swapout of apps I was using 3 minutes ago.  I've taken to walking away
for some coffee, coming back when it's done, and "sudo swapoff
/dev/hda3; sudo swapon -a" to avoid the latency that is so annoying when
trying to use bloaty apps.

[1] obviously I'll see some slowdown due to interrupts and PCI
    bandwidth; that's not what I'm railing against, here.

-andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWGGWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWGGWBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWGGWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:01:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43703 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932336AbWGGWBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:01:03 -0400
From: Neil Brown <neilb@suse.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sat, 8 Jul 2006 08:00:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17582.55703.209583.446356@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: message from Justin Piszcz on Friday July 7
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
	<Pine.LNX.4.64.0607071037190.5153@p34.internal.lan>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 7, jpiszcz@lucidpixels.com wrote:
> >> 
> >> Jul  7 08:44:59 p34 kernel: [4295845.933000] raid5: reshape: not enough 
> >> stripes.  Needed 512
> >> Jul  7 08:44:59 p34 kernel: [4295845.962000] md: couldn't update array 
> >> info. -28
> >> 
> >> So the RAID5 reshape only works if you use a 128kb or smaller chunk size?
> >> 
> 
> Neil,
> 
> Any comments?
> 

Yes.   This is something I need to fix in the next mdadm.
You need to tell md/raid5 to increase the size of the stripe cache
before the grow can proceed.  You can do this with

  echo 600 > /sys/block/md3/md/stripe_cache_size

Then the --grow should work.  The next mdadm will do this for you.

NeilBrown


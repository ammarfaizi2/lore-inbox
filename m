Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUHDTXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUHDTXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHDTXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:23:52 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:5897 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S267389AbUHDTXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:23:48 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Date: Wed, 4 Aug 2004 21:21:24 +0200
User-Agent: <Not available>
Cc: Jens Axboe <axboe@suse.de>, eric@cisu.net, kernel@kolivas.org,
       barryn@pobox.com, swsnyder@insightbb.com, linux-kernel@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com> <20040804130707.GN10340@suse.de> <20040804120633.4dca57b3.akpm@osdl.org>
In-Reply-To: <20040804120633.4dca57b3.akpm@osdl.org>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200408042121.24276@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 21:06, Andrew Morton wrote:

Hi Andrew,

> The 896M/128M split has a bit of a problem now each zone has its own LRU:
> the size of the highmem zone is less than the amount of memory which is
> described by the default /proc/sys/vm/dirty_ratio.  So it is easy to
> completely fill highmem with dirty pages.  This causes a fairly large
> amount of writeback via vmscan.c's writepage().  This causes poor I/O
> submission patterns.  This causes a simple large, linear `dd' write to run
> at only 50-70% of disk bandwidth.  (This was 6-12 months ago - it might be
> a bit better now)
> But I seem to be the only person who has noticed this yet ;) A workaround
> is to decrease dirty_ratio and dirty_background_ratio.

hmm, never tested to change the split with 2.6.x, but on 2.4 I didn't notice 
any disk i/o regressions. Maybe due to a different VM ;)


> Decreasing PAGE_OFFSET as above is attractive, but I believe 0xc0000000 is
> part of the ABI, and although we know (from the 4g/4g and other such
> patches) that everything will work OK, I wonder if it's really worth doing,
> especially as it's a compile-time thing.

> But hey, if someone can identify specific benefits from it then perhaps
> sneaking in a config option, or maintaining an external patch would be
> worthwhile.

Maybe we can introduce something like 3.5GB patch like 2.4-aa and 2.4-wolk 
has? For reference: 

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3/00_3.5G-address-space-5

Let me know and I'll cook up a 2.6 version.

Grmpf, that reminds me of my Documentation cleanup patches ;(

ciao, Marc

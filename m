Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317976AbSFSTGm>; Wed, 19 Jun 2002 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSFSTGl>; Wed, 19 Jun 2002 15:06:41 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:61889 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317976AbSFSTGk>; Wed, 19 Jun 2002 15:06:40 -0400
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
From: Steven Cole <scole@lanl.gov>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
References: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Jun 2002 13:04:52 -0600
Message-Id: <1024513492.13955.13.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 05:18, Craig Kulesa wrote:
> 
> 
> Where:  http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/
> 
> This patch implements Rik van Riel's patches for a reverse mapping VM 
> atop the 2.5.23 kernel infrastructure.  The principal sticky bits in 
> the port are correct interoperability with Andrew Morton's patches to 
> cleanup and extend the writeback and readahead code, among other things.  
> This patch reinstates Rik's (active, inactive dirty, inactive clean) 
> LRU list logic with the rmap information used for proper selection of pages 
> for eviction and better page aging.  It seems to do a pretty good job even 
> for a first porting attempt.  A simple, indicative test suite on a 192 MB 
> PII machine (loading a large image in GIMP, loading other applications, 
> heightening memory load to moderate swapout, then going back and 
> manipulating the original Gimp image to test page aging, then closing all 
> apps to the starting configuration) shows the following:
> 
> 2.5.22 vanilla:
> Total kernel swapouts during test = 29068 kB
> Total kernel swapins during test  = 16480 kB
> Elapsed time for test: 141 seconds
> 
> 2.5.23-rmap13b:
> Total kernel swapouts during test = 40696 kB
> Total kernel swapins during test  =   380 kB
> Elapsed time for test: 133 seconds
> 
> Although rmap's page_launder evicts a ton of pages under load, it seems to 
> swap the 'right' pages, as it doesn't need to swap them back in again.
> This is a good sign.  [recent 2.4-aa work pretty nicely too]
> 
> Various details for the curious or bored:
> 
> 	- Tested:   UP, 16 MB < mem < 256 MB, x86 arch. 
> 	  Untested: SMP, highmem, other archs. 
                    ^^^
I tried to boot 2.5.23-rmap13b on a dual PIII without success.

	Freeing unused kernel memory: 252k freed
hung here with CONFIG_SMP=y
	Adding 1052248k swap on /dev/sda6.  Priority:0 extents:1
	Adding 1052248k swap on /dev/sdb1.  Priority:0 extents:1

The above is the edited dmesg output from booting 2.5.23-rmap13b as an
UP kernel, which successfully booted on the same 2-way box.

Steven


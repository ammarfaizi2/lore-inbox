Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUCEUlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbUCEUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:41:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:42978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262697AbUCEUlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:41:10 -0500
Date: Fri, 5 Mar 2004 12:41:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, mingo@elte.hu, peter@mysql.com, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040305124119.756aab4c.akpm@osdl.org>
In-Reply-To: <20040305202941.GT4922@dualathlon.random>
References: <1078370073.3403.759.camel@abyss.local>
	<20040303193343.52226603.akpm@osdl.org>
	<1078371876.3403.810.camel@abyss.local>
	<20040305103308.GA5092@elte.hu>
	<20040305141504.GY4922@dualathlon.random>
	<20040305143210.GA11897@elte.hu>
	<20040305145837.GZ4922@dualathlon.random>
	<39960000.1078512175@flay>
	<20040305191329.GR4922@dualathlon.random>
	<56050000.1078516505@flay>
	<20040305202941.GT4922@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > > The main thing you didn't mention is the overhead in the per-cpu data
>  > > structures, that alone generates an overhead of several dozen mbytes
>  > > only in the page allocator, without accounting the slab caches,
>  > > pagetable caches etc.. putting an high limit to the per-cpu caches
>  > > should make a 32-way 32G work fine with 3:1 too though. 8-way is
>  > > fine with 32G currently.
>  > 
>  > Humpf. Do you have a hard figure on how much it actually is per cpu?
> 
>  not a definitive one, but it's sure more than 2m per cpu, could be 3m
>  per cpu.

It'll average out to 68 pages per cpu.  (4 in ZONE_DMA, 64 in ZONE_NORMAL).

That's eight megs on 32-way.  Maybe it can be trimmed back a bit, but on
32-way you probably want the locking amortisation more than the 8 megs.

The settings we have in there are still pretty much guesswork.  I don't
think anyone has done any serious tuning on them.  Any differences are
likely to be small.



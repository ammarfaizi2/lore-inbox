Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVC2X6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVC2X6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVC2X6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:58:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:2472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261651AbVC2X6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:58:12 -0500
Date: Tue, 29 Mar 2005 16:00:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
In-Reply-To: <200503281933.j2SJXJg22526@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0503291546180.6036@ppc970.osdl.org>
References: <200503281933.j2SJXJg22526@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Mar 2005, Chen, Kenneth W wrote:
> 
> With that said, here goes our first data point along with some historical data
> we have collected so far.
> 
> 2.6.11	-13%
> 2.6.9		- 6%
> 2.6.8		-23%
> 2.6.2		- 1%
> baseline	(rhel3)

How repeatable are the numbers across reboots with the same kernel? Some
benchmarks will depend heavily on just where things land in memory, 
especially with things like PAE or even just cache behaviour (ie if some 
frequenly-used page needs to be kmap'ped or not depending on where it 
landed).

You don't have the PAE issue on ia64, but there could be other issues.  
Some of them just disk-layout issues or similar, ie performance might
change depending on where on the disk the data is written in relationship
to where most of the reads come from etc etc. The fact that it seems to 
fluctuate pretty wildly makes me wonder how stable the numbers are.

Also, it would be absolutely wonderful to see a finer granularity (which 
would likely also answer the stability question of the numbers). If you 
can do this with the daily snapshots, that would be great. If it's not 
easily automatable, or if a run takes a long time, maybe every other or 
every third day would be possible?

Doing just release kernels means that there will be a two-month lag
between telling developers that something pissed up performance. Doing it
every day (or at least a couple of times a week) will be much more 
interesting.

I realize that testing can easily be overwhelming, but if something like 
this can be automated, and run in a timely fashion, that would be really 
great. Two months (or half a year) later, and we have absolutely _no_ idea 
what might have caused a regression. For example, that 2.6.2->2.6.8 change 
obviously makes pretty much any developer just go "I've got no clue".

In fact, it would be interesting (still) to go back in time if the
benchmark can be done fast enough, and try to do testing of the historical
weekly (if not daily) builds to see where the big differences happened. If
you can narrow down the 6-month gap of 2.6.2->2.6.8 to a week or a few
days, that would already make people sit up a bit - as it is it's too big
a problem for any developer to look at.

The daily patches are all there on kernel.org, even if the old ones have
been moved into /pub/linux/kernel/v2.6/snapshots/old/.. It's "just" a
small matter of automation ;)

Btw, this isn't just for you either - I'd absolutely _love_ it for pretty
much any benchmark. So anybody who has a favourite benchmark, whether
"obviously relevant" or not, and has the inclination to make a _simple_
daily number (preferably a nice graph), go for it. 

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbUKDGpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbUKDGpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUKDGpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:45:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:46805 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262096AbUKDGok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:44:40 -0500
Date: Thu, 4 Nov 2004 07:37:16 +0100
From: Andi Kleen <ak@suse.de>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
Cc: ak@suse.de, steiner@sgi.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041104063716.GA28895@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104040713.GC21211@wotan.suse.de> <20041104.135721.08317994.t-kochi@bq.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104.135721.08317994.t-kochi@bq.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 01:57:21PM +0900, Takayoshi Kochi wrote:
> Hi,
> 
> From: Andi Kleen <ak@suse.de>
> Subject: Re: Externalize SLIT table
> Date: Thu, 4 Nov 2004 05:07:13 +0100
> 
> > > Why not export node_distance() under sysfs?
> > > I like (1).
> > > 
> > > (1) obey one-value-per-file sysfs principle
> > > 
> > > % cat /sys/devices/system/node/node0/distance0
> > > 10
> > 
> > Surely distance from 0 to 0 is 0?
> 
> According to the ACPI spec, 10 means local and other values
> mean ratio to 10.  But what the distance number should mean

Ah, missed that. ok I guess it makes sense to use the same
encoding as ACPI, no need to be intentionally different.

> mean is ambiguous from the spec (e.g. some veondors interpret as
> memory access latency, others interpret as memory throughput
> etc.)
> However relative distance just works for most of uses, I believe.
> 
> Anyway, we should clarify how the numbers should be interpreted
> to avoid confusion.

Defining it as "as defined in the ACPI spec" should be ok. 
I guess even non ACPI architectures will be able to live with that.

Anyways, since we seem to agree and so far nobody has complained
it's just that somebody needs to do a patch?  If possible make
it generic code in drivers/acpi/numa.c, there won't be anything architecture 
specific in this and it should work for x86-64 too.


-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTJBWim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTJBWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:38:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:38669 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S263534AbTJBWij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:38:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Minutes from 10/1 LSE Call
Date: Fri, 3 Oct 2003 01:38:34 +0300
X-Mailer: KMail [version 1.4]
Cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@osdl.org>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <37940000.1065035945@w-hlinder> <200310022156.49678.insecure@mail.od.ua> <3F7C780C.9040001@pobox.com>
In-Reply-To: <3F7C780C.9040001@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310030138.34430.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 October 2003 22:10, Jeff Garzik wrote:
> insecure wrote:
> > That sounds reasonable, but today's RAM throughput is on the order
> > of 1GB/s, not 100Mb/s. 'Out of L1' theory can't explain 100Mb/s ceiling
> > it seems.
>
> cp(1) data, at least, will never ever be in L1.  Copying data you need
> to look at the ends of the pipeline -- hard drive throughput, PCI bus
> bandwidth, FSB bandwidth, speed at which ext2/3 allocates blocks, and
> similar things are likely bottlenecks.

Hmm.

On Wednesday 01 October 2003 22:19, Hanna Linder wrote:
> We got about 100 mb/sec using the bonie benchmark for block io writes,
> for writes we hit a ceiling around 100-120 mb/sec. Stopped scaling
> after about 3 spindles.
>
> Tried to focus on the block io part of it. Have not tried
> direct or raw io yet.  With block IO we got about 133 mb/sec
> doing a simple dd to dev/null from multiple spindles. This
> was on the 2.6 test 3.
> ....
> Odirect on large block sizes has low cpu utilization ( 3-5% ).
> However with buffered IO we can easily get to 100% cpu utilization.
> If you look at the profile most of that is in the copy_to_user function.

So:
* we hit a ceiling of ~133 Mb/s, no matter how many disks
* CPU utilization is 100%, spent mostly in copy_to_user
* RAM bandwidth is >1Gb/s

These can't be true at once.
At least one of these three statements must be false (imho).
-- 
vda

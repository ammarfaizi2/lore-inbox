Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTLJKeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 05:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLJKeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 05:34:23 -0500
Received: from dsl-213-023-231-202.arcor-ip.net ([213.23.231.202]:64901 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S263491AbTLJKeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 05:34:21 -0500
Message-ID: <3FD6F6A8.80907@kubla.de>
Date: Wed, 10 Dec 2003 11:34:16 +0100
From: Dominik Kubla <dominik@kubla.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Satchell <list@satchell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>	 <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>	 <1070975964.5966.5.camel@ssatchell1.pyramid.net>	 <Pine.LNX.4.53.0312090854080.8425@chaos>	 <1070981185.6243.58.camel@ssatchell1.pyramid.net>	 <Pine.LNX.4.53.0312091014250.525@chaos>  <3FD62845.8090301@kubla.de> <1071019731.8045.31.camel@ssatchell1.pyramid.net>
In-Reply-To: <1071019731.8045.31.camel@ssatchell1.pyramid.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:

> How does sampling free pages give you an accurate measurement of swap
> activity?  If I look at the free-page count at one-minute intervals, the
> system can, and WILL, inhale and exhale pages at a frightening clip, and
> there is no way I can see that sampling free-page count in a
> low-overhead way will do the trick.

First keep in mind that the Linux kernel uses paging instead of swapping 
out whole processes. So all you really are interested in is the sum of free 
pages and cache pages, because this is the amount of memory not yet used be 
running processes.

Second: If you happen to have a memory shortage, resulting in memory pages 
being paged out to disk, you will want to check with iostat the overall 
activity of the disk(s) your swap space (or rather paging space would be 
more accurate) is located.  If you have lots of paging activity you will 
want to have one or more otherwise idle disks (and on a different i/o path 
if possible) to put your swap space on ('iostat -x' is your friend).

If your system is continously paging, you will most likley need to add 
memory if you are concerned with performance, but that is also depending on 
the kind of work load your system has.

> How does vmstat disk-swap activity?  Looking at the source for vmstat in
> procps-2.0.11 I see how they do it for 2.4 kernels, but the part for 2.5
> kernels doesn't seem to try to pick up swap statistics at all -- because
> there are none to get?

First: you'll need sysstat installed (latest version appears to be 5.0). 
Forget about procps, it is not capable of what you need.

Second: as i tried to explain above, the collection of swap statistics is 
pretty much useless anyway. You need to look at pageing and i/o activity of 
the system as a whole.

Regards,
   Dominik Kubla
-- 
Those who can make you believe absurdities can make you commit
atrocities.    (Francois Marie Arouet aka Voltaire, 1694-1778)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVEMATI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVEMATI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVEMATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:19:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:19382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbVEMATG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:19:06 -0400
Date: Thu, 12 May 2005 17:18:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bruce Guenter <bruceg@em.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
Message-Id: <20050512171825.12599c1e.akpm@osdl.org>
In-Reply-To: <20050511193726.GA29463@em.ca>
References: <20050509035823.GA13715@em.ca>
	<1115627361.936.11.camel@localhost.localdomain>
	<20050511193726.GA29463@em.ca>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please always do reply-to-all)

Bruce Guenter <bruceg@em.ca> wrote:
>
> On Mon, May 09, 2005 at 10:29:21AM +0200, Alexander Nyberg wrote:
> > the patch below might help as it works on a lower
> > level. It accounts for bare pages in the system available
> > from /proc/page_owner. So a cat /proc/page_owner > tmpfile would be good
> > when the system starts to go low. There's a sorting program in
> > Documentation/page_owner.c used to sort the rather large output.
> 
> I've been running this for a day and a half now, and a few hundred megs
> of memory is now missing:
> 
> # free
>              total       used       free     shared    buffers     cached
> Mem:       2055648    2001884      53764          0     259024     868484
> -/+ buffers/cache:     874376    1181272
> Swap:      1028152         56    1028096
> 
> I've put the output from the sorting program up at
> 	http://untroubled.org/misc/page_owner_sorted
> 
> Is this useful information yet, or is there still too much in cached
> pages to really identify the source?

It all looks pretty innocent.  Please send the contents of /proc/meminfo
rather than the `free' output.  /proc/meminfo has much more info. 
Sometimes /proc/vmstat is also useful.

If the /proc/meminfo output indicates that there are a lot of slab pages
then /proc/slabinfo should be looked at.



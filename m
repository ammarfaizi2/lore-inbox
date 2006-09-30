Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWI3RAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWI3RAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWI3RAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:00:20 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:20891 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751301AbWI3RAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:00:19 -0400
To: rmk@arm.linux.org.uk
CC: dhylands@gmail.com, guinan@bluebutton.com, linux-kernel@vger.kernel.org
Subject: get_user_pages() cache issues on ARM
Message-Id: <E1GTiBq-0002i3-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Sep 2006 18:59:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

The get_user_pages() vs dcache coherency issue still seems to be
unresolved on ARM.

See flush_anon_page() and flush_kernel_dcache_page() in
Documentation/cachetlb.txt and their implementation on PARISC.

Can you please take a look at this?

Thanks,
Miklos

------- Start of forwarded message -------
Date: Sun, 24 Sep 2006 20:20:15 -0700
From: "Dave Hylands" <dhylands@gmail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [fuse-devel] ARM cross build issues
Cc: guinan@bluebutton.com, fuse-devel@lists.sourceforge.net
In-Reply-To: <E1GR461-0003WJ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Miklos,

Sending this to the list...

> > 2.6.18 still calls get_user_pages will the NULL vma. I verified that
> > the flush_cache_all patch made things work for me under 2.6.11
> > (big-endian ARM) and 2.6.17 (little-endian ARM).
>
> get_user_pages() should do the right thing on it's own.  So passing
> NULL vma is the normal thing to do, and the workaround should not be
> needed.
>
> So if 2.6.18 works without the patch, then it's fixed, otherwise not.

So 2.6.18 does NOT work on the ARM using the fuse.ko that gets built from the
kernel sources.

If I add the flush_cache_all() patch or the DCAHCE_BUG patch, then
everything works fine.

This was tested on my gumstix, which is an ARM XScale PXA255 running
in little-endian mode, using 2.6.18. I was using the hello filesystem
for the tests.

- -- 
Dave Hylands
Vancouver, BC, Canada
http://www.DaveHylands.com/
------- End of forwarded message -------

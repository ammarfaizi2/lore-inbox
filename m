Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVHDNe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVHDNe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVHDNe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:34:57 -0400
Received: from unthought.net ([212.97.129.88]:65180 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262521AbVHDNe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:34:56 -0400
Date: Thu, 4 Aug 2005 15:34:54 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>, cr@sap.com, linux-mm@kvack.org
Subject: Re: Getting rid of SHMMAX/SHMALL ?
Message-ID: <20050804133454.GY30510@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
	cr@sap.com, linux-mm@kvack.org
References: <20050804113941.GP8266@wotan.suse.de> <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 02:19:21PM +0100, Hugh Dickins wrote:
...
> > Even on 32bit architectures it is far too small and doesn't
> > make much sense. Does anybody remember why we even have this limit?
> 
> To be like the UNIXes.

 :)

...
> Anton proposed raising the limits last autumn, but I was a bit
> discouraging back then, having noticed that even Solaris 9 was more
> restrictive than Linux.  They seem to be ancient traditional limits
> which everyone knows must be raised to get real work done.

As I understand it (and I may be mistaken - if so please let me know) -
the limit is for SVR4 IPC shared memory (shmget() and friends), and not
shared memory in general.

It makes good sense to limit use of the old SVR4 shared memory
ressources, as they're generally administrator hell (doesn't free up
ressources on process exit), and just plain shouldn't be used.

It is my impression that SVR4 shmem is used in very few applications,
and that the low limit is more than sufficient in most cases.

Any proper application that really needs shared memory, can either
memory map /dev/null and share that map (swap backed shared memory) or
memory map a file on disk.

If the above makes sense and isn't too far from the truth, then I guess
that's a pretty good argument for maintaining status quo.

-- 

 / jakob


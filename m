Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbULANgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbULANgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbULANgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:36:10 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:13188 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261247AbULANgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:36:02 -0500
To: bulb@ucw.cz
CC: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <20041201071627.GB25969@vagabond> (message from Jan Hudec on Wed,
	1 Dec 2004 08:16:27 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <20041201071627.GB25969@vagabond>
Message-Id: <E1CZUdd-00079H-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 01 Dec 2004 14:35:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes they, can: the allocation will fail, function will return -ENOMEM,
> > malloc will return NULL, pagefault will fail with OOM.  This is
> > progress, though not the best sort.  It is most certainly _not_ a
> > deadlock.
> 
> Allocation won't fail! There's overcommit! Pagefault won't OOM, because
> it will wait for the pages to get laundered. And the pages won't get
> laundered untill the pagefault suceeds. (Yes, I know that you are going
> to mark the pages as dirty again so the pagefault won't wait for them,
> but you have to mention it.)

You didn't read the thread.  I was talking about the page not being
counted as dirty in the first place (bdi->memory_backed = 1).

If you want to see a machine out of physical memory (you can have
plenty of free swap), just try filling up a ramfs filesystem.  Don't
do it on the company's mission critical server though, cause some
people might be unhappy afterwards.

I tried it, and it's not very nice.  Even the OOM killer went to work
though swap was far from full.  And the end result was a perfectly
responsive, but not very useful system.

So please don't try to tell me that:

  a) it will deadlock: it won't, not even if userspace calls back,
  because the memory is _not_ reclaimable

  b) it's not a good solution: I _know_, all I'm trying to show that a
  deadlock is _not_ inherent in a userspace filesystem

Constructive comments are appreciated, others will go to /dev/null.

Thanks,
Miklos

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUH3QRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUH3QRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUH3QRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:17:13 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:53339 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268520AbUH3QRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:17:11 -0400
Date: Mon, 30 Aug 2004 18:18:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@mx20.domainteam.dk>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read EXTRAVERSION from file
Message-ID: <20040830161854.GA24580@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@mx20.domainteam.dk>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <20040830151405.GA18836@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830151405.GA18836@lst.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 05:14:05PM +0200, Christoph Hellwig wrote:
> The're an very interesting patch in the Debian tree still from the time
> where Herbert Xu mentioned it, it allows creating a file .extraversion
> in the toplevel kernel directory and the Makefile will set EXTRAVERSION
> to it's contents.  This has the nice advantage of keeping an
> extraversion pre-tree instead of having to patch the Makefile and
> getting rejects everytime you pull a new tree (or BK refuses to touch
> the Makefile).
> 
> The only thing I'm not fully comfortable is the .extraversion name, I
> think I'd prefer a user-visible name.
> 
> Any other comments on this one?
> 
> --- kernel-source-2.6.6/Makefile	2004-05-10 19:47:45.000000000 +1000
> +++ kernel-source-2.6.6-1/Makefile	2004-05-10 22:21:02.000000000 +1000
> @@ -151,6 +151,9 @@
>  
>  export srctree objtree VPATH TOPDIR
>  
> +ifeq ($(EXTRAVERSION),)
> +EXTRAVERSION := $(shell [ ! -f .extraversion ] || cat .extraversion)
> +endif
>  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

This would fail for 2.6.8.1 for instance. Or at least the '1' that Linus 
added would be part of the final EXTRAVERSION.

Ian Wienand <ianw@gelato.unsw.edu.au> posted a patch some time ago that
introduces LOCALVERSION - it's in my queue but not applied since it
needs some rework. And documentation also.
That should be easy to extend to read the file localversion.

I would then prefer something like:
If exists $(srctree)/localversion read file and append to LOCALVERSION
If exists $(objtree)/localversion read file and append to LOCALVERSION


Example for a debian patched kernel src tree:

srctree:
localversion <= contains -deb-unstb-7.9
objtree:
localversion <= contains -smp-p4

Resulting in a kernelversion equals: 2.6.8-rc1-deb-unstb-7.9-smp-p4

	Sam

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279368AbRJWK5k>; Tue, 23 Oct 2001 06:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279369AbRJWK5a>; Tue, 23 Oct 2001 06:57:30 -0400
Received: from ns.caldera.de ([212.34.180.1]:52652 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S279368AbRJWK5T>;
	Tue, 23 Oct 2001 06:57:19 -0400
Date: Tue, 23 Oct 2001 12:57:16 +0200
Message-Id: <200110231057.f9NAvGI31569@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: viro@math.psu.edu (Alexander Viro)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cdrom-related rmmod races
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.GSO.4.21.0110230640520.7440-100000@weyl.math.psu.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0110230640520.7440-100000@weyl.math.psu.edu> you wrote:
> 	Folks, patch below should fix the rmmod/open() races for
> cdrom drivers (including pcd and sr).  The problem with the current
> code is that they use cdrom_open() as ->open() and bump module
> refcount only in cdrom_device_info->open() callback.  cdrom_open()
> blocks before calling it, with obvious results.

> 	Patch is pretty straightforward - it gives these guys ->open()
> of their own that does MOD_INC_USE_COUNT and calls cdrom_open() - see
> below for examples.  Please, give it a try - if there's no complaints it
> goes to Linus.

Wouldn't it be easier to add a 'struct module *owner' to struct
block_device_operations?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

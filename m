Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129531AbRB0RyX>; Tue, 27 Feb 2001 12:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbRB0RyN>; Tue, 27 Feb 2001 12:54:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40975 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129531AbRB0Rx6>; Tue, 27 Feb 2001 12:53:58 -0500
Subject: Re: [PATCH] Core dumps for threads
To: ddugger@willie.n0ano.com (Don Dugger)
Date: Tue, 27 Feb 2001 17:55:45 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010227102954.A26230@willie.n0ano.com> from "Don Dugger" at Feb 27, 2001 10:29:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XoLk-0003tW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the 2.4.1 kernel, that copies the mm and dumps the corefile from
> that copy.  Also, whenever there are multiple users of the original
> mm it creates the core dump in the file `core.n' where `n' is the
> PID of the offending process.

> +	if ((mm = kmem_cache_alloc(mm_cachep, SLAB_KERNEL)) == NULL)
> +		goto close_fail;
> +	memcpy(mm, current->mm, sizeof(*mm));
> +	if (!mm_init(mm)) {
> +		kmem_cache_free(mm_cachep, mm);
> +		goto close_fail;
> +	}
> +	down(&current->mm->mmap_sem);

Umm not quite what I meant. Take a look at copy_mm in fork.c

The code starting

	m = allocate_mm()

down to just before

	/*
  	 * child gets a 

Does the real thing you need to do to be sure the mm is properly set up.
You can also drop the original mm and make that current->mm to avoid the
passing of mm around. In fact you probably should do that.


	





Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUJFEfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUJFEfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUJFEfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:35:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:50193 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267184AbUJFEfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:35:02 -0400
Date: Wed, 6 Oct 2004 06:34:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006043458.GB19761@alpha.home.local>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 12:58:57AM +0300, Denis Vlasenko wrote:
> > +		if (open("/dev/null", O_RDWR, 0) == 0)
> > +			printk("         Falling back to /dev/null.\n");
> > +	}
> 
> What will happen if /dev is totally empty?

... Which is the most probable reason causing this trouble.
I've long wondered why the kernel could not open the /dev/console fds itself
since they are character devices, so handled by the kernel internally. It
should be possible to bypass the file-system access and get the fds anyway.
Or we might need some tricks such as populate rootfs with 'console' before
mounting root, open it, remove the entry while keeping the fd for use after
the real root is mounted. This way, it would not be the real /dev/console
which would be passed to init, so it would never even have to exist.

Comments ?

Willy


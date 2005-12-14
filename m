Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbVLNBlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVLNBlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVLNBls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:41:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:63924 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030236AbVLNBls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:41:48 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
References: <20051213172325.GC16392@lst.de>
	<20051213173434.GP9286@parisc-linux.org>
	<20051213.145109.20744871.davem@davemloft.net>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 02:41:42 +0100
In-Reply-To: <20051213.145109.20744871.davem@davemloft.net>
Message-ID: <p73r78g8nft.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Matthew Wilcox <matthew@wil.cx>
> Date: Tue, 13 Dec 2005 10:34:34 -0700
> 
> > The 64-bit code doesn't compile because Andi keeps blocking the
> > is_compat_task() stuff.
> 
> The one place where I ever thought that was necessary, the
> USB async userspace I/O operation stuff, was solved much more
> cleanly with ->compat_ioctl() file_operations handlers.
> 
> What do you really still need it for at this point?

input needs it :/ Take a look at drivers/input/evdev.c:evdev_write_compat
Someone should roast in hell for that code.

> I also would like to avoid it if possible.

I have given in for now. Assuming the test is done on a flag that is only set
by the system call entry path. But I still think it will result in
a lot of ugly code. For for read/write it's hard to avoid because
there are so many variants and we have too many message passing
protocols now.

That said I have been too lazy so far to actually implement it:/

-Andi

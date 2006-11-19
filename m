Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756694AbWKSO2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694AbWKSO2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756696AbWKSO2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:28:31 -0500
Received: from [198.99.130.12] ([198.99.130.12]:11745 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1756694AbWKSO2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:28:30 -0500
Date: Sun, 19 Nov 2006 09:25:07 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml fails to compile due to missing offsetof
Message-ID: <20061119142507.GA3284@ccure.user-mode-linux.org>
References: <20061119120000.GA4926@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119120000.GA4926@aepfle.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 01:00:01PM +0100, Olaf Hering wrote:
> 
> I fail to see how arch/um/sys-i386/user-offsets.c can compile since
> offsetof() was declared __KERNEL__ only in include/linux/stddef.h.
> Does it work for anyone else? 

It obviously works for me.  offsetof is very standard C.  I'd venture
to say that a system which can't find it has a broken gcc installation.

> If so, is linux/stddef.h or /usr/include/linux/stddef.h used during
> compilation?

/usr/include/linux/stddef.h (but see below) - this is a userspace
file, so it builds against libc headers.

> The x86_64 variant looks weird as well, linux/stddef.h is appearently
> included via some other headers.

Well, /usr/include/linux/stddef.h on my x86_64 box has no offsetof,
despite being FC5 just like my i386 laptop.  Yay for consistency.

However, there is a /usr/lib/gcc/x86_64-redhat-linux/4.1.1/include/stddef.h
which defines offsetof (and there's a corresponding file on my
laptop), so I bet that's the true source of offsetof.

				Jeff
-- 
Work email - jdike at linux dot intel dot com

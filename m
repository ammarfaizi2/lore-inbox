Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTIHNiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbTIHNgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:36:35 -0400
Received: from ns.suse.de ([195.135.220.2]:38551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262201AbTIHNdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:33:10 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
References: <Pine.LNX.4.44.0309071617380.21192-100000@home.osdl.org>
	<200309081503.20459.arnd@arndb.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: If I am elected, the concrete barriers around the WHITE HOUSE
 will be replaced by tasteful foam replicas of ANN MARGARET!
Date: Mon, 08 Sep 2003 15:33:08 +0200
In-Reply-To: <200309081503.20459.arnd@arndb.de> (Arnd Bergmann's message of
 "Mon, 8 Sep 2003 15:03:20 +0200")
Message-ID: <jeptibxv57.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> --- 1.1/include/asm-i386/ioctl.h	Tue Feb  5 18:39:44 2002
> +++ edited/include/asm-i386/ioctl.h	Mon Sep  8 13:21:28 2003
> @@ -52,11 +52,21 @@
>  	 ((nr)   << _IOC_NRSHIFT) | \
>  	 ((size) << _IOC_SIZESHIFT))
>  
> +/* provoke compile error for invalid uses of size argument */
> +extern int __invalid_size_argument_for_IOC;
> +#define _IOC_TYPECHECK(t) \
> +	((sizeof(t) == sizeof(t[1]) && \
> +	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
> +	  sizeof(t) : __invalid_size_argument_for_IOC)

This will fail when compiled unoptimized, which means that glibc could not
use <asm/ioctls.h> any more.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

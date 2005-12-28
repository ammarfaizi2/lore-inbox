Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVL1SjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVL1SjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVL1SjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:39:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:1180 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964865AbVL1SjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:39:13 -0500
Date: Wed, 28 Dec 2005 18:39:12 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 01/2] allow gcc4 to control inlining
Message-ID: <20051228183912.GF27946@ftp.linux.org.uk>
References: <20051228114653.GB3003@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228114653.GB3003@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 12:46:53PM +0100, Ingo Molnar wrote:
> allow gcc4 compilers to decide what to inline and what not - instead
> of the kernel forcing gcc to inline all the time.

> +#define noinline		__attribute__((noinline))
> +#define __always_inline		inline __attribute__((always_inline))
>  #define __must_check 		__attribute__((warn_unused_result))
>  #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)

You seem to be missing the rest of the patch - namely, addition of
always_inline where it is needed now...

Note that we *do* need it in quite a few places.  Anything that relies on
dead code elimination to kill a call of function that doesn't exist
would better be always inlined...

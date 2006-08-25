Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422866AbWHYPxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422866AbWHYPxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422867AbWHYPxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:53:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:21917 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422866AbWHYPxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:53:49 -0400
Subject: Re: [PATCH] Pass sparse the lock expression given to lock
	annotations
From: Josh Triplett <josht@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060824210531.6264f285.akpm@osdl.org>
References: <1156466936.3418.58.camel@josh-work.beaverton.ibm.com>
	 <20060824210531.6264f285.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 08:53:53 -0700
Message-Id: <1156521234.3420.19.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 21:05 -0700, Andrew Morton wrote:
> On Thu, 24 Aug 2006 17:48:56 -0700
> Josh Triplett <josht@us.ibm.com> wrote:
> 
> > The lock annotation macros __acquires, __releases, __acquire, and __release
> > all currently throw the lock expression passed as an argument.  Now that
> > sparse can parse __context__ and __attribute__((context)) with a context
> > expression, pass the lock expression down to sparse as the context expression.
> 
> What is the dependency relationship between your kernel changes and your
> proposed change to sparse?

Sparse with my multi-context patch will continue to parse versions of
the kernel without this kernel patch, since I made the context
expression optional in sparse.  Versions of sparse without my
multi-context patch will not parse kernels with this kernel patch (since
previous versions of sparse will not support the extra argument).  The
same dependency relationship has held true with past additions to sparse
and the kernel; furthermore, that dependency relationship often exists
anyway due to the use of new GCC extensions in the kernel which require
changes to the sparse parser, such as __builtin_types_compatible_p,
__builtin_extract_return_addr, __builtin_va_copy, and
__attribute__((no_instrument_function)).

- Josh Triplett



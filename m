Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUA2N0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 08:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUA2N0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 08:26:30 -0500
Received: from mail.shareable.org ([81.29.64.88]:9091 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S265150AbUA2N03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 08:26:29 -0500
Date: Thu, 29 Jan 2004 13:26:23 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040129132623.GB13225@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401894DA.7000609@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> ~ alternatively use the symbol table the vdso has.  Export the new code
> only via the symbol table.  No fixed address for the function, the
> runtime gets it from the symbol table.  glibc will use weak symbol
> references; if the symbol isn't there, the old code is used.  This will
> require that every single optimized syscall needs to be handled special.
> 
> 
> I personally like the first approach better.  The indirection table can
> maintained in sync with the syscall table inside the kernel.  It all
> comes at all times from the same source.  The overhead of the memory
> load should be neglectable.

I like the second approach more.  You can change glibc to look up the
weak symbol for _all_ syscalls, then none of them are special and it
will work with future kernel optimisations.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUJ1KIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUJ1KIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUJ1KIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:08:24 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:3797 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262873AbUJ1KFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:05:12 -0400
Date: Thu, 28 Oct 2004 03:04:57 -0700 (PDT)
From: Sorav Bansal <sbansal@stanford.edu>
To: Andrew Morton <akpm@osdl.org>
cc: tacetan@yahoo.com, <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: User/Kernel Pointer bug in sys_poll
In-Reply-To: <20041028024839.6a1e1064.akpm@osdl.org>
Message-ID: <Pine.GSO.4.44.0410280255040.14448-100000@elaine37.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nope.  The only significant difference between copy_from_user() and
> __put_user() here is that copy_from_user() checks that the address is not
> in the 0xc0000000-0xffffffff range.  __put_user() skips that check.

This is true for modern x86 architectures.

For some older 386's, where Write-Protect does not work okay, there is a
difference between put_user() and copy_from_user(). put_user() performs an
extra check called verify_write() in addition to checking the address
range. Hence, the following code may be unsafe when running on those
machines.

> So
>
> 	if (copy_from_user(kaddr, addr, n))
> 		fail();
> 	__put_user(42, addr);
>
> is safe.  We know that the address is in the 0x00000000-0xbfffffff range by
> the time we call __put_user().  And if the page at *addr it not writeable
> the kernel will take a fault.

In older 386's, the kernel will NOT take a fault and write to the
write-protected region.

But then, maybe 386 is too old to worry about :-)


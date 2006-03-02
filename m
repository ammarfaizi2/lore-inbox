Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWCBECV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWCBECV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWCBECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:02:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750935AbWCBECV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:02:21 -0500
Date: Wed, 1 Mar 2006 20:01:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure when cached memory is close to the
 total memory.
Message-Id: <20060301200106.080bd72a.akpm@osdl.org>
In-Reply-To: <6d6a94c50603011937p61bea6ddl691ee1cdb309d14d@mail.gmail.com>
References: <6d6a94c50603010154hbbcdb68n8cd7e05f7f30aba5@mail.gmail.com>
	<20060301023604.76ce5658.akpm@osdl.org>
	<6d6a94c50603011937p61bea6ddl691ee1cdb309d14d@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey <aubreylee@gmail.com> wrote:
>
> > The chances of finding 10MB of contiguous free pages are basically nil, so
> > the page allocator doesn't even try to free up pages to attempt to satisfy
> > such a large request.  If it can't find the 10MB of free memory
> > immediately, it just gives up.
> 
> Nope.

Yup.

> I've tested the case on the host. See below. The allocation for
> 300MB was sucessful when the cached memory was close to the total
> memory.

The host has an MMU and hence is able to map discontiguous physical pages
into a virtually contiguous block.  The blackfin doesn't have an MMU and
hence requires that 10MB's worth of physically contiguous pages be free. 
Which is so hard to achieve after the system has been up for a while that
the kernel won't even attempt it.

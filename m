Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272920AbTHKRai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272898AbTHKR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:27:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48618 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S272821AbTHKRYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:24:12 -0400
Date: Mon, 11 Aug 2003 19:19:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
In-Reply-To: <3F37BED1.405@colorfullife.com>
Message-ID: <Pine.LNX.4.56.0308111917170.17605@localhost.localdomain>
References: <3F361F5E.10106@colorfullife.com> <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain>
 <3F37B4B7.9010108@colorfullife.com> <Pine.LNX.4.56.0308111723040.11173@localhost.localdomain>
 <3F37BED1.405@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Aug 2003, Manfred Spraul wrote:

> > this is not a bug technically, unless the mount options are in the
> > last linearly mapped page. It is a bug to copy those unallocated
> > bytes, but they do not get to relied upon. Note that the non-4G code 
> > copies them just as much.
>
> Or unless there are holes in the memory map, or unless pages were 
> unmapped from the kernel linear mapping for GART.
> IMHO the currect code is unacceptable.

IMHO the mount-options API is quite unclean - since when do we guarantee
-EFAULT semantics?

> It is possible to use direct_copy_ instead of memcpy for fs==KERNEL_DS
> in mm/usercopy.c?

yes. But i still think we should fix the API too.

	Ingo

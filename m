Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUL3SAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUL3SAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 13:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUL3SAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 13:00:34 -0500
Received: from one.firstfloor.org ([213.235.205.2]:43699 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261685AbUL3SA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 13:00:28 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: kmalloc packet slab
References: <1104156983.20944.25.camel@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: Thu, 30 Dec 2004 19:00:25 +0100
In-Reply-To: <1104156983.20944.25.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 27 Dec 2004 14:16:23 +0000")
Message-ID: <m1hdm3ll8m.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> The networking world runs in 1514 byte packets pretty much all the time.
> This adds a 1620 byte slab for such objects and is one of the internally
> generated Red Hat patches we use on things like Fedora Core 3. Original:
> Arjan van de Ven.

Doesnt this clash a bit with yours and Arjans no-prisoners-taken 
quest to get rid of order>0 allocations? (4K stacks). 

I implemented this long ago (in 2.1 - bonus points if you still find
the leftover hook), but then gave up on it. I realized that to
use it you would need order>0 allocations. In a single 4K page only 2
1.5K slabs fit, but 2 2K slabs fit as well. And there is already a handy
2K slab that works perfect well.

IMHO it is useless except for architectures with PAGE_SIZE>4K or if 
you fix the VM to handle order>0 allocations really well. If you want
to add it for sparc64/ia64/alpha etc. I would do it with an ifdef
at least. 

-Andi
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTLDBac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTLDBab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:30:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:51920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263088AbTLDBa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:30:27 -0500
Date: Wed, 3 Dec 2003 17:29:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Timothy Miller <miller@techsource.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix locking in input
In-Reply-To: <3FCE7569.5080305@techsource.com>
Message-ID: <Pine.LNX.4.58.0312031725580.2055@home.osdl.org>
References: <3FC13382.3060701@colorfullife.com> <20031123223443.A560@flint.arm.linux.org.uk>
 <3FC13AA0.9030204@colorfullife.com> <3FCE7569.5080305@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Timothy Miller wrote:
>
> This is MOSTLY true, but not entirely.  As I recall, Alpha has two
> addressing modes: Sparse and Dense.

Nope. Alpha only does "dense" addressing on a CPU level.

What the _system_ designers on most PCI systems did was to map the PCI
address space twice: once through a "dense" mapping and once through a
"sparse" mapping. In the sparse mapping the low address bits give byte
enable information, while in the dense mapping you can onyl do 32-bit and
64-bit aligned operations.

But the original alpha CPU couldn't do the sparse mapping - in particular
the above only worked with non-cached accesses.

So "real memory" was always dense, and could not atomically be accessed
with byte/word writes (you could use the atomic "load-locked" +
"store-conditional" to do them, but at a huge performance loss, and
obviously the compilers never did that).

		Linus

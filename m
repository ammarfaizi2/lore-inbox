Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTDUNfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 09:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTDUNfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 09:35:39 -0400
Received: from ns.suse.de ([213.95.15.193]:41222 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261282AbTDUNfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 09:35:38 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER]  Help Needed!
References: <3EA3B87B.60505@colorfullife.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Apr 2003 15:47:37 +0200
In-Reply-To: <3EA3B87B.60505@colorfullife.com.suse.lists.linux.kernel>
Message-ID: <p7365p8x8qu.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:
 
> P.S.: On i386, you can access both kernel and user space after
> set_fs(KERNEL_DS), or if you use __get_user() and bypass
> access_ok(). Thus the __get_user() in arch/i386/kernel/traps.c,
> function show_registers is correct. This is the only instance I'm
> aware of where this is used, and noone else should be doing that. It
> fails on other archs, e.g. on sparc.

It is used in a couple more of places in the x86-64 architecture specific
code. Of course it is legal there too.

Also there are some corner cases; e.g. some architecture specific
code (particularly the 32bit emulations) just does access_ok or 
get_user/put_user (with implied access_ok) on the first element 
of a structure and then accesses the other elements with __*_user.
This works because these architectures have an unmapped hole at the 
end of the user address space.

But in most other cases (in general outside arch/) it is very likely
a bug and a security hole.

-Andi

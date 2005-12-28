Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVL1Pa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVL1Pa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVL1Pa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:30:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:11502 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964841AbVL1Pa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:30:57 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
References: <20051228114701.GC3003@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 28 Dec 2005 16:30:49 +0100
In-Reply-To: <20051228114701.GC3003@elte.hu>
Message-ID: <p734q4tb5na.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> allow gcc4 compilers to optimize unit-at-a-time - which results in gcc
> having a wider scope when optimizing. This also results in smaller code
> when optimizing for size. (gcc4 does not have the stack footprint
> problem of gcc3 compilers.)

I never had any trouble with stack footprint even with gcc 3.3 on x86-64
and unit-at-a-time and it was always enabled. 

But one caveat: turning on unit-at-a-time makes objdump -S / make
foo/bar.lst with CONFIG_DEBUG_INFO essentially useless because objdump
cannot deal with functions being out of order in the object file. This
can be a big problem while analyzing oopses - essentially you have
to analyze the functions without source level information. And with
unit-at-a-time they become bigger so it's more difficult.

But I still think it's a good idea.

-Andi

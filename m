Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTEABeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 21:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTEABeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 21:34:06 -0400
Received: from ns.suse.de ([213.95.15.193]:26628 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261281AbTEABeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 21:34:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <87d6j34jad.fsf@student.uni-tuebingen.de.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0304301801210.20283-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 May 2003 03:46:18 +0200
In-Reply-To: <Pine.LNX.4.44.0304301801210.20283-100000@home.transmeta.com.suse.lists.linux.kernel>
Message-ID: <p73ade730d1.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Yeah, except if you want best code generation you should probably use
> 
> 	static inline int fls(int x)
> 	{
> 		int bit;
> 		/* Only well-defined for non-zero */
> 		asm("bsrl %1,%0":"=r" (bit):"rm" (x));

"g" should work for the second operand too and it'll give gcc
slightly more choices with possibly better code.

But the __builtin is probably preferable if gcc supports it because
a builtin can be scheduled, inline assembly can't.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWGID3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWGID3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWGID3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:29:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161078AbWGID3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:29:30 -0400
Date: Sat, 8 Jul 2006 20:29:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile' 
In-Reply-To: <31410.1152414469@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.64.0607082019180.5623@g5.osdl.org>
References: <31410.1152414469@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Keith Owens wrote:
> 
> This disagrees with the gcc (4.1.0) docs.  info --index-search='Extended Asm' gcc
> 
>   The ordinary output operands must be write-only; GCC will assume
>   that the values in these operands before the instruction are dead and
>   need not be generated.  Extended asm supports input-output or
>   read-write operands.  Use the constraint character `+' to indicate
>   such an operand and list it with the output operands.  You should
>   only use read-write operands when the constraints for the operand (or
>   the operand in which only some of the bits are to be changed) allow a
>   register.

I'm fairly sure the docs are outdated (but may well be correct for older 
gcc versions - as I already discussed elsewhere, that "+" thing was not 
historically useful).

We've been using "+m" for some time in the kernel on several 
architectures.

git aficionados can do

	git grep -1 '"+m"' v2.6.17

to see the pre-existing usage of this (most of them go back a lot further, 
although some of them are newer - the <asm-i386/bitops.h> ones were added 
in January.

So if "+m" didn't work, we've been in trouble for at least the last year.

			Linus

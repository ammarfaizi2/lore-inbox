Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269893AbUIDLe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269893AbUIDLe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUIDLcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:32:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:57795 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269896AbUIDLQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:16:17 -0400
Date: Sat, 4 Sep 2004 13:16:05 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
Message-ID: <20040904111605.GA12165@wotan.suse.de>
References: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 08:03:02PM -0400, Zwane Mwaikambo wrote:
>  arch/x86_64/kernel/time.c        |   13 +++++++++++++
>  arch/x86_64/kernel/vmlinux.lds.S |    1 +
>  include/asm-x86_64/ptrace.h      |    4 ++++
>  3 files changed, 18 insertions(+)
> 
> Andi, i'm not so sure about that return address in profile_pc, i think i
> need to read a bit more.

When frame pointers are enabled the code is correct. But you don't 
even need frame pointers, because the spinlock code should not
spill any registers and in such a function the return address
is always *rsp. Same is true on i386 too. 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUIFRzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUIFRzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIFRwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:52:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:44487 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268381AbUIFRuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:50:22 -0400
Date: Mon, 6 Sep 2004 19:50:21 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
Message-ID: <20040906175021.GA27258@wotan.suse.de>
References: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com> <20040904111605.GA12165@wotan.suse.de> <Pine.LNX.4.58.0409041420590.11262@montezuma.fsmlabs.com> <20040906072859.GB31343@wotan.suse.de> <Pine.LNX.4.53.0409061211440.14053@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409061211440.14053@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 12:19:24PM -0400, Zwane Mwaikambo wrote:
> Hi Andi,
> 
> On Mon, 6 Sep 2004, Andi Kleen wrote:
> 
> > That is with frame pointers enabled. Indeed with frame pointers
> > on it is not true you still have to special case that.
> 
> Yes that was with frame pointers enabled, but the following was compiled 
> without frame pointers, i'm still not sure it's safe to use *esp.

No, it's not unfortunately. gcc is aligning the stack 
to 8 bytes for floating point. It would if you compiled the file with 
-mpreferred-stack-boundary=4. Actually AFAIK this is only useful
for floating point anyways, so it would be a good idea to always
compile the kernel with this option.

On x86-64 it should just work.

-Andi



> 
> 00000070 <_spin_lock>:
>   70:   83 ec 04                sub    $0x4,%esp

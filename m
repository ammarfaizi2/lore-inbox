Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWHUW6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWHUW6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWHUW6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:58:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56079 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751285AbWHUW6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:58:37 -0400
Date: Tue, 22 Aug 2006 00:58:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060821225837.GT11651@stusta.de>
References: <20060821212154.GO11651@stusta.de> <20060821232444.9a347714.ak@suse.de> <20060821214636.GP11651@stusta.de> <20060822000903.441acb64.ak@suse.de> <20060821222412.GS11651@stusta.de> <20060822002728.c023bf85.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822002728.c023bf85.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 12:27:28AM +0200, Andi Kleen wrote:
> 
> > It disables the automatic usage of builtins which is OK.
> 
> No, it's not ok -- it is the problem. We want to use the builtins.

Without -ffreestanding, the compiler is completely free to decide 
whether to use a builtin or whether to not use it - and which other C 
library functions to use.

Your commit 6edfba1b33c701108717f4e036320fc39abe1912 that claimed
"it was only added for x86-64, so dropping it should be safe" was not 
safe, it had broken at least mips and m68k. This wrong justification 
alone should warrant a revert of this commit.

What's the problem with adding -ffreestanding and stating explicitely 
which functions we want to be handled be builtins, and which functions 
we don't want to be handled by builtins?

This looks like the right way to go instead of breaking other 
architectures here and there.

> -Andi

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli


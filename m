Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423694AbWKPKaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423694AbWKPKaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423742AbWKPKaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:30:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41372 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423694AbWKPKaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:30:02 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch, -rc6] x86_64: UP build fix, arch/x86_64/kernel/mce_amd.c
Date: Thu, 16 Nov 2006 11:29:56 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061116102115.GA8379@elte.hu>
In-Reply-To: <20061116102115.GA8379@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611161129.56502.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 11:21, Ingo Molnar wrote:
> Subject: [patch] x86_64: UP build fix, arch/x86_64/kernel/mce_amd.c
> From: Ingo Molnar <mingo@elte.hu>
> 
> fix x86_64/kernel/mce_amd.c build bug:
> 
>  arch/x86_64/kernel/mce_amd.c: In function ‘threshold_remove_bank’:
>  arch/x86_64/kernel/mce_amd.c:597: error: ‘shared_bank’ undeclared (first use in this function)
>  arch/x86_64/kernel/mce_amd.c:597: error: (Each undeclared identifier is reported only once
>  arch/x86_64/kernel/mce_amd.c:597: error: for each function it appears in.)
>  make[1]: *** [arch/x86_64/kernel/mce_amd.o] Error 1
>  make: *** [arch/x86_64/kernel/mce_amd.o] Error 2
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>


Hmm, it builds for me.

% grep SMP .config
CONFIG_BROKEN_ON_SMP=y
# CONFIG_X86_VSMP is not set
# CONFIG_SMP is not set
% grep MCE_AMD .config
CONFIG_X86_MCE_AMD=y
% ls -l vmlinux 
-rwxr-xr-x  1 andi users 9174494 2006-11-16 10:20 vmlinux

(basically just defconfig with CONFIG_SMP disabled) 

Perhaps a include ordering problem?  Can you send your .config?

-Andi


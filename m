Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUBXXtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUBXXtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:49:22 -0500
Received: from ns.suse.de ([195.135.220.2]:38803 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262335AbUBXXtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:49:21 -0500
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA2684@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Feb 2004 00:49:19 +0100
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA2684@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
Message-ID: <p73n078598g.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> writes:

> Other than the standard IA-32 differences (eg. HT, SSE3, Intel Enhanced
> SpeedStep, etc.), there are few differences between the implementations
> of 
> IA-32e and AMD64. The software visible ones are:

Thanks for the detailed list.

> BSF/BSR when source is 0 & operand size is 32:
>   In 64-bit mode, the processor sets ZF, and the upper 32 bits of 
>   the destination are undefined. Should always check the ZF or do not
> use 
>   32-bit operand size.

This one sounds a bit scary. I think it could hurt the 
asm-x86_64/bitops.h:find_first_zero_bit if there is a race that 
changes the value in memory between the last scasl and the bsfl
and the inliner assumes the edx output argument is zero extended.
Hopefully that case should be unlikely enough. I guess best would
be to change the function to use 64bit accesses to avoid this completely.

-Andi

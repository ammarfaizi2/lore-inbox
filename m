Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTIPLq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTIPLq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:46:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12948 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261829AbTIPLq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:46:58 -0400
Date: Tue, 16 Sep 2003 12:46:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: richard.brunner@amd.com
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916114636.GF26576@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com wrote:
> Andi's patch solves both the kernel space and the user space
> issues in a pretty small footprint.

Not really.  Userspace still has a problem when run on older kernels,
so it will have to check for AMD and kernel version anyway before
deciding to use the prefetch instruction.  That, or install SIGSEGV
and SIGBUS handlers to do the fixup in userspace.

> The user space problem worries me more, because the expectation
> is that if CPUID says the program can use perfetch, it could
> and should regardless of what the kernel decided to do here.

If the workaround isn't compiled in, "prefetch" should be removed from
/proc/cpuinfo on the buggy chips.

-- Jamie

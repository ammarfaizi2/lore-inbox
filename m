Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWCECrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWCECrN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWCECrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:47:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751017AbWCECrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:47:12 -0500
Date: Sat, 4 Mar 2006 18:45:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: hostmaster@ed-soft.at, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] EFI: Fix gdt load
Message-Id: <20060304184524.4e9d422f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603020755090.28074@montezuma.fsmlabs.com>
References: <4406F0C2.7090002@ed-soft.at>
	<Pine.LNX.4.64.0603020755090.28074@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Thu, 2 Mar 2006, Edgar Hucek wrote:
> 
> > This patch makes the kernel bootable again on ia32 EFI systems.
> > 
> > Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
> > 
> 
>  	spin_lock(&efi_rt_lock);
>  	local_irq_save(efi_rt_eflags);
> 
> That looks like a race, not to mention that efi_rt_eflags is a global 
> variable. The same strange ordering occurs on unlock, i presume this code 
> 'works' because it's done early during boot?

No, the code's OK.  This is the prologue function.  The epilogue function
does the opposite.   In between, this CPU will dink around with EFI stuff.

And the order is correct too - the lock protects efi_rt_eflags.

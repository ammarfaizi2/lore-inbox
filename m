Return-Path: <linux-kernel-owner+willy=40w.ods.org-S772931AbUKBFT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S772931AbUKBFT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273763AbUKBFT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:19:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:16608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S273659AbUKBFP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 00:15:26 -0500
Date: Mon, 1 Nov 2004 22:13:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, nathanl@austin.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
Message-Id: <20041101221336.5f6d8534.akpm@osdl.org>
In-Reply-To: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> This patch changes mmu_context_init to be called as a core_initcall
>  rather than an arch_initcall, since mmu_context_init needs to run
>  before we try to run any userspace processes, and arch_initcall was
>  found to be too late.

Here we go again...

I don't see why your patch fixes the problem.  do_basic_setup() calls
driver_init() prior to any initcalls being run, and driver_init() can call
/sbin/hotplug.


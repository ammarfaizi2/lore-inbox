Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVBCKKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVBCKKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVBCKKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:10:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30850 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262363AbVBCKKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:10:02 -0500
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<20050203.160252.104031714.taka@valinux.co.jp>
	<1107421303.11609.183.camel@2fwv946.in.ibm.com>
	<20050203.183747.85413533.taka@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 03:07:58 -0700
In-Reply-To: <20050203.183747.85413533.taka@valinux.co.jp>
Message-ID: <m1hdku6jnl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi <taka@valinux.co.jp> writes:

> Hi Vivek, 
> 
> > > Hi Vivek and Eric,
> > > 
> > > IMHO, why don't we swap not only the contents of the top 640K
> > > but also kernel working memory for kdump kernel?
> > 
> > 
> > Initial patches of kdump had adopted the same approach but given the
> > fact devices are not stopped during transition to new kernel after a
> > panic, it carried inherent risk of some DMA going on and corrupting the
> > new kernel/data structures. Hence the idea of running the kernel from a
> > reserved location came up. This should be DMA safe as long as DMA is not
> > misdirected.
> 
> I see, that makes sense.
> But I'm not sure yet that it's safe to access the top of 640MB.
640K?

> I wonder how kmalloc(GFP_DMA) works in a kdump kernel.

All that happens there is a one line change to vmlinux.lds.S  that
causes the kernel to live at a different physical and virtual
address.  So everything works as normal.

I do agree that it is risky to use the first 640K for normal work.
But on the list of things to fix it is a minor war, and even if we
back up that region of memory we don't need to use it.

There are still remain a lot of code reviews to ensure the code is
generally safe.

Eric

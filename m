Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275344AbTHSE2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275346AbTHSE2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:28:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:28883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275344AbTHSE20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:28:26 -0400
Date: Mon, 18 Aug 2003 21:29:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davej@redhat.com, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-Id: <20030818212951.11e13c98.akpm@osdl.org>
In-Reply-To: <32829.4.4.25.4.1061264369.squirrel@www.osdl.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
	<20030815173246.GB9681@redhat.com>
	<20030815123053.2f81ec0a.rddunlap@osdl.org>
	<20030816070652.GG325@waste.org>
	<20030818140729.2e3b02f2.rddunlap@osdl.org>
	<20030819001316.GF22433@redhat.com>
	<20030818171545.5aa630a0.akpm@osdl.org>
	<32789.4.4.25.4.1061263463.squirrel@www.osdl.org>
	<20030818203513.393c4a48.akpm@osdl.org>
	<32829.4.4.25.4.1061264369.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Call Trace:
>   [<c0120d93>] __might_sleep+0x53/0x74
>   [<c010d001>] save_v86_state+0x71/0x1f0
>   [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
>   [<c019cac8>] ext3_file_write+0x28/0xc0
>   [<c011cd96>] __change_page_attr+0x26/0x220
>   [<c010b310>] do_general_protection+0x0/0x90
>   [<c010a69d>] error_code+0x2d/0x40
>   [<c0109657>] syscall_call+0x7/0xb
> 
>  My (more) vague understanding is that X(?) got the kernel to
>  do_general_protection() somehow, but change_page_attr() does this:
>  	spin_lock_irqsave(&cpa_lock, flags);
>  in arch/i386/mm/pageattr.c (I'm on a UP box),
>  so irqs are disabled by the kernel and then we calls put_user()
>  with a spinlock held.

The __change_page_attr() there looks like stack gunk.


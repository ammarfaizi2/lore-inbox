Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWFAQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWFAQZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWFAQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:25:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030225AbWFAQZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:25:40 -0400
Date: Thu, 1 Jun 2006 09:29:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, Chris Leech <christopher.leech@intel.com>
Subject: Re: 2.6.17-rc5-mm2 another compile error
Message-Id: <20060601092953.169064d5.akpm@osdl.org>
In-Reply-To: <447ED2AB.30107@aitel.hist.no>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447ED2AB.30107@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 13:42:35 +0200
Helge Hafting <helge.hafting@aitel.hist.no> wrote:

>   CC      drivers/dma/ioatdma.o
> drivers/dma/ioatdma.c: In function ‘ioat_init_module’:
> drivers/dma/ioatdma.c:828: error: dereferencing pointer to incomplete type
> make[2]: *** [drivers/dma/ioatdma.o] Error 1
> make[1]: *** [drivers/dma] Error 2
> make: *** [drivers] Error 2
> 

        if (THIS_MODULE != NULL)
                THIS_MODULE->unsafe = 1;

Chris, this won't compile with CONFIG_MODULES=n.

If module unloading is unsafe (why?) then a suitable workaround would be to
take an additional ref on the module (__module_get()) so that it cannot be
unloaded.


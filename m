Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265972AbUFEEvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUFEEvM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 00:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUFEEvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 00:51:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:13527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265972AbUFEEvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 00:51:09 -0400
Date: Fri, 4 Jun 2004 21:50:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eduard Bloch <blade@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HOWTO...] LUFS, readpage and large files
Message-Id: <20040604215029.49cd02a2.akpm@osdl.org>
In-Reply-To: <20040604155103.GA15021@zombie.inka.de>
References: <20040604155103.GA15021@zombie.inka.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch <blade@debian.org> wrote:
>
>     offset = p->index << PAGE_CACHE_SHIFT;
>      count = PAGE_SIZE;
> 
>  The problem is, page->index indeed contains a short datatype for offset -
>  ...but where to get the correct data? (the long long offset).

p->index is a 32-bit type.  So (p->index << PAGE_CACHE_SHIFT) is also
32-bit, and stuff overflows.  Do:

	offset = p->index;
	offset <<= PAGE_CACHE_SHIFT;

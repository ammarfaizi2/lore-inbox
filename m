Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUJATLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUJATLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUJATLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:11:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:37573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266163AbUJATLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:11:43 -0400
Date: Fri, 1 Oct 2004 12:09:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
Message-Id: <20041001120926.4d6f58d5.akpm@osdl.org>
In-Reply-To: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I randomly see "ps" hangs on my AMD64 system running 2.6.9-rc2-mm4.
>  I don't remember seeing this on earlier kernels. Is this something
>  known/fixed ?

hm.  I can see that access_process_vm() is doing lock_page() inside
mmap_sem, which is a ranking bug, but it's not that.

And I see a distinct lack of flush_foo_page() calls after the by-hand
modification of the user page.  But it's not that either.

Can you work out who is holding mmap_sem for writing?

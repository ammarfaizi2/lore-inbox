Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUA3TqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUA3TqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:46:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:37554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263661AbUA3Tpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:45:46 -0500
Date: Fri, 30 Jan 2004 11:47:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: thomas.schlichter@web.de, thoffman@arnor.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Tim Hockin <thockin@sun.com>
Subject: Re: 2.6.2-rc2-mm2
Message-Id: <20040130114701.18aec4e8.akpm@osdl.org>
In-Reply-To: <1075490624.4272.7.camel@laptop.fenrus.com>
References: <20040130014108.09c964fd.akpm@osdl.org>
	<1075489136.5995.30.camel@moria.arnor.net>
	<200401302007.26333.thomas.schlichter@web.de>
	<1075490624.4272.7.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> 
> directly calling sys_ANYTHING sounds really wrong to me...
> 

It's a philosophical thing.  Is a kernel thread like a user process which
happens to be running from the kernel or it is a piece of mainline kernel
code which happens to have its own execution context?  I rather favour the
latter...

In this case it looks like it will just happen to work, because
nfsd_setuser() is executed by nfsd, and kernel threads are allowed to do
copy_from_user() with the source in kernel memory.  ick.

Tim, I do think it would be neater to add another entry point in sys.c for
nfsd and just do a memcpy.

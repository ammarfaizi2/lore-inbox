Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWCQVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWCQVGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWCQVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:06:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932197AbWCQVGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:06:19 -0500
Date: Fri, 17 Mar 2006 13:03:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ericvh@hera.kernel.org, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net, ericvh@gmail.com
Subject: Re: [RESEND][PATCH] v9fs: print v9fs module address
Message-Id: <20060317130311.0477454f.akpm@osdl.org>
In-Reply-To: <20060317194113.GA8848@infradead.org>
References: <200603171909.k2HJ9BiD006068@hera.kernel.org>
	<20060317194113.GA8848@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Mar 17, 2006 at 07:09:14PM +0000, Eric Van Hensbergen wrote:
>  > Subject: [PATCH] print v9fs module address
>  > From: Latchesar Ionkov <lucho@ionkov.net>
>  > Date: 1141313037 -0500
>  > 
>  > This patch prints v9fs module address when the module is initialized. It is
>  > useful to have it in the logs -- if the kernel crashes the address can be
>  > used together with the oops print to find out the exact place (presumably in
>  > the v9fs code) that cause the oops.
> 
>  NACK.
> 
>  This just clutters the log.  The information is provided in /proc/modules
>  for all modules.

But it's not printed out in an oops record and it can be hard to read
/proc/modules when the kernel is dead.

That being said...

If we really want this info then it should be printed out by the oops code,
where it prints the names of all the loaded modules - add "(0xc0123456)"
after each module name.

But I can't say I've ever felt a need for this feature - the symbolic info
in the oops trace tells you function_name+0xoffset/0xsize [*] which is
sufficient info for debugging.

IOW: what's the use case here, Eric?



[*] unless it's x86_64, which randomly prints some of these things in
    decimal or sanskrit or something.


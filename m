Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752078AbWFWVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWFWVYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWFWVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:24:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752078AbWFWVYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:24:40 -0400
Date: Fri, 23 Jun 2006 14:24:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
Message-Id: <20060623142430.333dd666.akpm@osdl.org>
In-Reply-To: <449C3817.2030802@garzik.org>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
	<449C3817.2030802@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 14:51:03 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Linux Kernel Mailing List wrote:
> > commit e6022603b9aa7d61d20b392e69edcdbbc1789969
> > tree f94b059e312ea7b2f3c4d0b01939e868ed525fb0
> > parent 304c4c841a31c780a45d65e389b07706babf5d36
> > author Andrew Morton <akpm@osdl.org> Fri, 23 Jun 2006 16:05:32 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 23 Jun 2006 21:43:05 -0700
> > 
> > [PATCH] ext3_clear_inode(): avoid kfree(NULL)
> > 
> > Steven Rostedt <rostedt@goodmis.org> points out that `rsv' here is usually
> > NULL, so we should avoid calling kfree().
> > 
> > Also, fix up some nearby whitespace damage.
> > 
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> Dumb question...  why?  kfree(NULL) has always been explicitly allowed.
> 

Because at that callsite, NULL is the common case.  We avoid a do-nothing
function call most of the time.  It's a nano-optimisation.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271094AbTGPUBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271095AbTGPUBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:01:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271094AbTGPUBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:01:37 -0400
Date: Wed, 16 Jul 2003 13:09:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030716130915.035a13ca.akpm@osdl.org>
In-Reply-To: <20030716184609.GA1913@kroah.com>
References: <20030716184609.GA1913@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Here's a patch against 2.6.0-test1-mm that fixes up the different places
> where we export a dev_t to userspace.  This fixes all of the compiler
> warnings that were previously reported with these files.

I added this as well:

static inline char *format_dev_t(char *buffer, dev_t dev)
{
	sprintf(buffer, "%04lx\n", (unsigned long)dev);
	return buffer;
}

tp be placed direct in a printk().

We'll probably need to do something more fancy in here later, because once
a dev_t becomes 32:32, it'll need to be printed out with "%016llx", which
is daft.

So we'll need to come up with some standardised way of presenting a dev_t
to the user.  Presumably that will just be

	sprintf(buf, "%d:%d", major(dev), minor(dev));
	
But if we do this, will it break your existing stuff?

> If I should put the print_dev_t() function in a different header file,
> please let me know.

Seems OK.  Every kdev_t.h includer now needs to include kernel.h too.  Fair
enough.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbUEGT4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUEGT4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUEGT4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 15:56:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:41446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263713AbUEGTzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 15:55:50 -0400
Date: Fri, 7 May 2004 12:13:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com
Subject: Re: Is it possible to implement interrupt time printk's reliably?
Message-Id: <20040507121319.6939b391.akpm@osdl.org>
In-Reply-To: <20040507133403.39224.qmail@web14923.mail.yahoo.com>
References: <20040506221746.7bb45421.akpm@osdl.org>
	<20040507133403.39224.qmail@web14923.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@yahoo.com> wrote:
>
> > If you're in process context you can use acquire_console_sem(), which will
> > serialise against printk.
> > 
> 
> Won't I deadlock if I have acquire_console_sem(), take an interrupt, and then a
> printk is issued from the interrupt handelr?
> 

Nope.  If printk finds the semaphore to be held it queues up the characters
and returns without printing them.  The console_sem-holding process will
print the newly buffered characters before releasing the semaphore.

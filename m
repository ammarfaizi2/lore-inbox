Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269501AbUINQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269501AbUINQNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUINQMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:12:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6104 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269454AbUINQFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:05:24 -0400
Date: Tue, 14 Sep 2004 09:05:12 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: James Roper <u3205097@anu.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel semaphores
Message-Id: <20040914090512.7236a6da@lembas.zaitcev.lan>
In-Reply-To: <mailman.1095139743.24686.linux-kernel2news@redhat.com>
References: <mailman.1095139743.24686.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 15:25:24 +1000
James Roper <u3205097@anu.edu.au> wrote:

> [] So my question is, if my semaphore is 
> causing that error, what possible things could be triggering it?  Could it be 
> an interrupt while waiting to acquire the semaphore?  I'm using the 
> down_interruptible() to acquire and up() to release.

You have to use spinlocks to provide a mutual exclusion to interrupts.
However, a process on CPU cannot sleep while holding a spinlock. So,
sometimes it's needed to create a derivative locking scheme, based
on spinlocks. A common trick is to combine semaphores and spinlocks.
I cannot be more specific without knowing your code.

-- Pete

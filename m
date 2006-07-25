Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWGYAX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWGYAX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWGYAX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:23:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932346AbWGYAX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:23:58 -0400
Date: Mon, 24 Jul 2006 17:20:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: vxfs_readdir locking incorrect: add lock_kernel() or remove
 unlock_kernel()?
Message-Id: <20060724172040.c177f173.akpm@osdl.org>
In-Reply-To: <1153780937.31581.13.camel@josh-work.beaverton.ibm.com>
References: <1153780937.31581.13.camel@josh-work.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 15:42:17 -0700
Josh Triplett <josht@us.ibm.com> wrote:

> Commit 7b2fd697427e73c81d5fa659efd91bd07d303b0e in the historical GIT
> tree stopped calling the readdir member of a file_operations struct with
> the big kernel lock held, and fixed up all the readdir functions to do
> their own locking.  However, that change added calls to unlock_kernel()
> in vxfs_readdir (fs/freevxfs/vxfs_lookup.c), but no call to
> lock_kernel().

That would appear to imply that nobody has used freevxfs in four years.

>  Should vxfs_readdir call lock_kernel(), or should the
> calls to unlock_kernel() go away?

I don't see anything in there which needs the locking, apart from perhaps
f_pos updates.  But it's probably best to add the lock_kernel() - this is a
bugfixing exercise, not a remove-BKL-from-freevxfs exercise.

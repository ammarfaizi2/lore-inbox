Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUDPXhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUDPXhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:37:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:64906 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263325AbUDPXfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:35:25 -0400
Date: Fri, 16 Apr 2004 16:37:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: k.gavrilenko@arhont.com
Cc: mlists@arhont.com, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.5-mm6 reiserfs and hpt366 problems
Message-Id: <20040416163703.36a89df4.akpm@osdl.org>
In-Reply-To: <408057A5.6010604@arhont.com>
References: <408057A5.6010604@arhont.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Gavrilenko <mlists@arhont.com> wrote:
>
> Apr 16 22:45:06 filo kernel: Debug: sleeping function called from 
> invalid context at drivers/block/ll_rw_blk.c:1156
> Apr 16 22:45:06 filo kernel: in_atomic():0, irqs_disabled():1
> Apr 16 22:45:06 filo kernel: Call Trace:
> Apr 16 22:45:06 filo kernel:  [<c0117449>] __might_sleep+0x99/0xb0
> Apr 16 22:45:06 filo kernel:  [<c02950bf>] generic_unplug_device+0x1f/0x60
> Apr 16 22:45:06 filo kernel:  [<c02d9fc9>] unplug_slaves+0x69/0x70

Ah, I see it.  There are several instances of unplug_slaves().  The one in
raid1.c is incorrectly calling ->unplug_fn() under spin_lock_irq().


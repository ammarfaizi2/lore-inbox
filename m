Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUFVTBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUFVTBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFVTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:01:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:28050 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265089AbUFVS6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:58:47 -0400
Date: Tue, 22 Jun 2004 11:57:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
 do_mmap_pgoff
Message-Id: <20040622115748.396badfe.akpm@osdl.org>
In-Reply-To: <1087913598.1512.264.camel@watt.suse.com>
References: <1087837153.1512.176.camel@watt.suse.com>
	<20040621171337.44d1b636.akpm@osdl.org>
	<1087913598.1512.264.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> Hmmm, reiserfs_file_write does fault_in_pages_readable after the
>  transaction is started.

That nests down_read(mmap_sem) inside transaction start, vastly increasing
the deadlock probability.

>  I can at least make the window smaller for now
>  by moving that before the transaction is started.

Much smaller.

We need to decide what the ranking is and stick with it.  I think that's
"transaction start nests inside mmap_sem", agree?
	

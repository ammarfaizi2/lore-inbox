Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUEYV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUEYV6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUEYV6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:58:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:47238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265132AbUEYV4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:56:44 -0400
Date: Tue, 25 May 2004 14:59:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-Id: <20040525145923.68af0ad8.akpm@osdl.org>
In-Reply-To: <20040525144836.1af59a96.akpm@osdl.org>
References: <20040525184732.GB26661@suse.de>
	<20040525144836.1af59a96.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Olaf Hering <olh@suse.de> wrote:
> >
> > Any ideas why the location of the device node makes such a big
> > difference? I always wondered why my firewire is so dog slow with 2.6.
> > Now I know the reason: /dev is in tmpfs.
> > I dont see that with IDE disks, only with SCSI.
> 
> This is truly bizarre.

It affects IDE too - the context switch and interrupt rates are through the
roof.  IDE disks have always seemed better at doing readahead, which is why
the transfer bandwidth is much the same.

Everything there is consistent with "not doing readahead".  The fickle
finger points in the general direction of fs/block_dev.c:do_open().  Later.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbULHF6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbULHF6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbULHF6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:58:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:5034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262034AbULHF6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:58:48 -0500
Date: Tue, 7 Dec 2004 21:58:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [path 2.6] reduce ext3 log spamming (blank lines)
Message-Id: <20041207215833.4d63e22f.akpm@osdl.org>
In-Reply-To: <200412071501.15815.david-b@pacbell.net>
References: <200412071501.15815.david-b@pacbell.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> wrote:
>
> When drives go offline, e.g. usb-storage disconnect, the
> upper layers don't behave very intelligently yet:  ext3
> over scsi keeps retrying reads, logging three lines for
> each error:
> 
> 10:58:31  scsi0 (0:0): rejecting I/O to dead device
> 10:58:31  EXT3-fs error (device sda1): ext3_find_entry: reading directory #18089296 offset 0
> 10:58:31  
> 10:58:55  scsi0 (0:0): rejecting I/O to dead device
> ...
> This patch shrinks that log spam by the trivial third, getting
> rid of those needless blank lines.

Thanks.

>  It's not clear to me why
> the "no such device" errors don't immediately make ext3
> (or is it the block layer?) give up ... maybe someone else
> can make Linux not retry after those errors.

It's probably ext3 directory readahead.

We deliberately ignore I/O error when reading directories so that if you
have a bad block in a directory it is still possible to recover files which
are addressed by later blocks.


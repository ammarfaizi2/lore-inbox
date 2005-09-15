Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVIOCs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVIOCs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVIOCs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:48:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030327AbVIOCsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:48:55 -0400
Date: Wed, 14 Sep 2005 19:48:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][FAT] miss-sync issues on sync mount (miss-sync on
 write)
Message-Id: <20050914194820.5bbddcb3.akpm@osdl.org>
In-Reply-To: <43288964.7020307@sm.sony.co.jp>
References: <43288964.7020307@sm.sony.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> wrote:
>
> This patch fixes miss-sync issue on write() system call.
>  This updates inode attrs flags, mtime and ctime on every
>  comit_write call, due to locking.

This all seems wrong.

Why does fatfs have file_operations.write pointing at do_sync_write()
rather than generic_file_write()?

Why does fatfs have a custom .aio_write() rather than using
generic_file_aio_write()?

If fatfs can use all the standard library functions, all this inode
dirtying and O_SYNC/-o sync handling shoud just work.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTGaWoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274824AbTGaWoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:44:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:62929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270621AbTGaWoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:44:00 -0400
Date: Thu, 31 Jul 2003 15:32:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Muthian S" <muthian_s@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: madvise on file pages
Message-Id: <20030731153211.16c9ccb3.akpm@osdl.org>
In-Reply-To: <Law11-F124d2VqKwRPQ00000a39@hotmail.com>
References: <Law11-F124d2VqKwRPQ00000a39@hotmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Muthian S" <muthian_s@hotmail.com> wrote:
>
> Hi,
> 
> Could someone inform as to what is the behavior when madvise DONTNEED is 
> called on pages that are mmap'd from local files mapped with MAP_SHARED, 
> i.e. they share the same page that the file cache does.

The pages are unmapped from the calling process's pagetables.  We don't
actually free the physical pages.

> In such cases, can 
> madvise be made to release specific pages in the file cache by mmap-ing the 
> relevant file segment ?

No.

2.6 kernels implement the fadvise() syscall (accessible by glibc's
posix_fadvise() function) which will do this.


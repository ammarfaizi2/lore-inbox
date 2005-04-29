Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVD2Lzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVD2Lzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVD2Lzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:55:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:45511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262501AbVD2Lzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:55:38 -0400
Date: Fri, 29 Apr 2005 04:54:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3: Bad page state at prep_new_page
Message-Id: <20050429045447.44649c8e.akpm@osdl.org>
In-Reply-To: <17006.3525.908807.563680@alkaid.it.uu.se>
References: <17006.3525.908807.563680@alkaid.it.uu.se>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@user.it.uu.se> wrote:
>
> My trusty network server (440BX PentiumIII box serving NFS and News)
>  just threw the following at me:
> 
>  Bad page state at prep_new_page (in process 'python', page c10984e0)
>  flags:0x20021008 mapping:00000000 mapcount:0 count:0
>  Backtrace:
>   [<c0137555>] bad_page+0x75/0xb0
>   [<c01378aa>] prep_new_page+0x2a/0x70
>   [<c0137e60>] buffered_rmqueue+0xc0/0x1c0
>   [<c01380f0>] __alloc_pages+0xc0/0x400
>   [<c01425a9>] do_anonymous_page+0x79/0x150
>   [<c0142870>] do_no_page+0x1f0/0x360
>   [<c0142c2d>] handle_mm_fault+0x13d/0x170
>   [<c0110c92>] do_page_fault+0x2a2/0x6bf
>   [<c0111d12>] recalc_task_prio+0xc2/0x170
>   [<c026b49b>] schedule+0x31b/0x5c0
>   [<c01109f0>] do_page_fault+0x0/0x6bf
>   [<c0102dbf>] error_code+0x4f/0x54
>  Trying to fix it up, but a reboot is needed
> 
>  It's running 2.6.12-rc3 since last Friday, but had been running
>  2.6.12-rc2 for weeks before that w/o problems. 2.4 kernels and
>  most recent 2.6 kernels have always been rock solid on it.
> 

PG_swapcache is set.  It wasn't set when this page was returned to the page
allocator.

>  This is the first time this box has had a problem like this.
>  While I can't rule out bad memory (I'll memtest86 it when I
>  get a chance to), I'm inclined to suspect a 2.6 kernel bug.

Could be a bug, but it'd be a damn unusual one.  I wouldn't rule out a
bitflip.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbSLJUPH>; Tue, 10 Dec 2002 15:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSLJUPH>; Tue, 10 Dec 2002 15:15:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29081 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266377AbSLJUPF>;
	Tue, 10 Dec 2002 15:15:05 -0500
Date: Tue, 10 Dec 2002 12:19:08 -0800 (PST)
Message-Id: <20021210.121908.00373632.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: marcelo@conectiva.com.br, raul@pleyades.net
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212101931.gBAJV1K10639@hera.kernel.org>
References: <200212101931.gBAJV1K10639@hera.kernel.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
   Date: Tue, 10 Dec 2002 15:51:07 +0000

   +
   +/*
   + *	NOTE: in this function we rely on TASK_SIZE being lower than
   + *	SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
   + */
   +

This assumption is wrong.  It is totally possible for TASK_SIZE
to be the entire 64-bit address space on sparc64 and thus larger
than SIZE_MAX - PAGE_SIZE, and I definitely plan on supporting
that.

User processes live entirely in their very own address space seperate
from the kernel, so kernel stuff does not take up any part of the user
virtual addresses.

Please revert this change, it adds absolutely nothing.

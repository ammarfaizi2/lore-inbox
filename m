Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268476AbUIFTiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbUIFTiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUIFTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:38:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:62338 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268476AbUIFTiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:38:09 -0400
Date: Mon, 6 Sep 2004 12:35:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Q: bugs in generic_forget_inode()?
Message-Id: <20040906123534.3487839e.akpm@osdl.org>
In-Reply-To: <413C52E2.10809@sw.ru>
References: <413C52E2.10809@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Hello,
> 
> 1. I found that generic_forget_inode() calls write_inode_now() dropping 
> inode_lock and destroys inode after that. The problem is that 
> write_inode_now() can sleep and during this sleep someone can find inode 
> in the hash, w/o I_FREEING state and with i_count = 0.

The filesystem is in the process of being unmounted (!MS_ACTIVE).  So the
question is: who is doing inode lookups against a soon-to-be-defunct
filesystem?



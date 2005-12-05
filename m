Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVLEUNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVLEUNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVLEUNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:13:30 -0500
Received: from pat.uio.no ([129.240.130.16]:52720 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751398AbVLEUN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:13:29 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>
References: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 15:13:10 -0500
Message-Id: <1133813590.12393.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.826, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 10:01 -0800, Kenny Simpson wrote:
> Tested with rc5 - same results.  It was suggested that I run slabtop when the system freezed, so
> here is that info: (again, by hand, I'm getting another machine to use either netconsole or a
> serial cable).
> 
>  Active / Total Objects (% used)    : 478764 / 485383 (98.6%)
>  Active / Total Slabs (% used)      : 14618 / 14635 (99.9%)
>  Active / Total Caches (% used)     : 79 / 138 (57.2%)
>  Active / Total Size (% used)       : 56663.79K / 57566.41K (98.4%)
>  Minimum / Average / Maximum Object : 0.01K / 0.12K / 128.00K
> 
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
> 403088 403088 100%    0.06K   6832       59     27328K nfs_page
>  30380  30380 100%    0.50K   4340        7     17360K nfs_write_data
>  15134  15134 100%    0.27K   1081       14      4324K radix_tree_node
> ...
> 
> 
> The other thing is that the stack trace showsd slabtop as being halted in throttle_vm_writeout
> while allocating memory, and the writetest was halted waiting to allocate memory.

Can somebody VM-savvy please explain how on earth they expect something
like throttle_vm_writeout() to make progress? Shouldn't that thing at
the very least be kicking pdflush every time it loops?

Cheers,
  Trond

> I'll get more detailed stack traces once I get the second machine set up.
> 
> -Kenny
> 
> 
> 
> 		
> __________________________________ 
> Start your day with Yahoo! - Make it your home page! 
> http://www.yahoo.com/r/hs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


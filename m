Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVAEKJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVAEKJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 05:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAEKJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 05:09:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:14034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262313AbVAEKJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 05:09:21 -0500
Date: Wed, 5 Jan 2005 02:08:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105020859.3192a298.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> Still untested, but posting the concept here anyway, since this
>  could explain a lot...
> 
>  OOM kills have been observed with 70% of the pages in lowmem being
>  in the writeback state.  If we count those pages in sc->nr_scanned,
>  the VM should throttle and wait for IO completion, instead of OOM
>  killing.
> 
>  Signed-off-by: Rik van Riel <riel@redhat.com>
> 
>  --- linux-2.6.9/mm/vmscan.c.screclaim	2005-01-03 12:17:56.547148905 -0500
>  +++ linux-2.6.9/mm/vmscan.c	2005-01-03 12:18:16.855965416 -0500
>  @@ -376,10 +376,10 @@
> 
>    		BUG_ON(PageActive(page));
> 
>  +		sc->nr_scanned++;
>    		if (PageWriteback(page))
>    			goto keep_locked;
> 
>  -		sc->nr_scanned++;

Patch looks very sane.  It in fact restores that which we were doing until
12 June 2004, when the rampant `struct scan_control' depredations violated
the tree.


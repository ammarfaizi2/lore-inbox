Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTKMD6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 22:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTKMD6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 22:58:11 -0500
Received: from rth.ninka.net ([216.101.162.244]:34956 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261974AbTKMD6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 22:58:08 -0500
Date: Wed, 12 Nov 2003 19:56:01 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Inefficient TLB flushing
Message-Id: <20031112195601.6c9b718d.davem@redhat.com>
In-Reply-To: <20031112200119.GA22429@sgi.com>
References: <20031112200119.GA22429@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003 14:01:19 -0600
Jack Steiner <steiner@sgi.com> wrote:

> --- /usr/tmp/TmpDir.19957-0/linux/mm/memory.c_1.79	Wed Nov 12 13:56:25 2003
> +++ linux/mm/memory.c	Wed Nov 12 12:57:25 2003
> @@ -574,9 +574,10 @@
>  			if ((long)zap_bytes > 0)
>  				continue;
>  			if (need_resched()) {
> +				int fullmm = (*tlbp)->fullmm;
>  				tlb_finish_mmu(*tlbp, tlb_start, start);
>  				cond_resched_lock(&mm->page_table_lock);
> -				*tlbp = tlb_gather_mmu(mm, 0);
> +				*tlbp = tlb_gather_mmu(mm, fullmm);
>  				tlb_start_valid = 0;
>  			}
>  			zap_bytes = ZAP_BLOCK_SIZE;

This patch looks perfectly fine, good analysis.

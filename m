Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbUKUVNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUKUVNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUKUVNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:13:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:36770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261810AbUKUVNF (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:13:05 -0500
Date: Sun, 21 Nov 2004 13:12:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux-Kernel@vger.kernel.org, AKPM@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-Id: <20041121131250.26d2724d.akpm@osdl.org>
In-Reply-To: <16800.47044.75874.56255@gargle.gargle.HOWL>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <nikita@clusterfs.com> wrote:
>
> Batch mark_page_accessed() (a la lru_cache_add() and lru_cache_add_active()):
>  page to be marked accessed is placed into per-cpu pagevec
>  (page_accessed_pvec). When pagevec is filled up, all pages are processed in a
>  batch.
> 
>  This is supposed to decrease contention on zone->lru_lock.

Looks sane, althought it does add more atomic ops (the extra
get_page/put_page).  Some benchmarks would be nice to have.


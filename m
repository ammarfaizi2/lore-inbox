Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTFLRLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTFLRLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:11:31 -0400
Received: from [198.149.18.6] ([198.149.18.6]:43707 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264911AbTFLRKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:10:53 -0400
Subject: Re: [2.5.70][XFS] Sleeping function called from illegal context
From: Steve Lord <lord@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612181837.A8344@infradead.org>
References: <20030612170756.GA1357@dreamland.darkstar.lan>
	 <20030612181837.A8344@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055438639.6614.112.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 12:24:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 12:18, Christoph Hellwig wrote:
> --- 1.53/fs/xfs/pagebuf/page_buf.c	Mon May 19 21:00:43 2003
> +++ edited/fs/xfs/pagebuf/page_buf.c	Wed Jun 11 21:30:21 2003
> @@ -1689,10 +1689,10 @@
>  	int			pincount = 0;
>  	int			flush_cnt = 0;
>  
> +	pagebuf_runall_queues(pagebuf_dataio_workqueue);
> +
>  	spin_lock(&pbd_delwrite_lock);
>  	INIT_LIST_HEAD(&tmp);
> -
> -	pagebuf_runall_queues(pagebuf_dataio_workqueue);
>  
>  	list_for_each_safe(curr, next, &pbd_delwrite_queue) {
>  		pb = list_entry(curr, page_buf_t, pb_list);

Yep, I will check this in.

Thanks Christoph,

 Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com

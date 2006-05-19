Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWESSIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWESSIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWESSIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:08:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751333AbWESSIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:08:11 -0400
Date: Fri, 19 May 2006 11:10:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Lever <cel@citi.umich.edu>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 1/6] nfs: "open code" the NFS direct write rescheduler
Message-Id: <20060519111054.1842ccfb.akpm@osdl.org>
In-Reply-To: <20060519180020.3244.75979.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519180020.3244.75979.stgit@brahms.dsl.sfldmi.ameritech.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@netapp.com> wrote:
>
> +	 * Prevent I/O completion while we're still rescheduling
> +	 */
> +	dreq->outstanding++;
> +

No locking.

>  	dreq->count = 0;
> +	list_for_each(pos, &dreq->rewrite_list) {
> +		struct nfs_write_data *data =
> +			list_entry(dreq->rewrite_list.next, struct nfs_write_data, pages);
> +
> +		spin_lock(&dreq->lock);
> +		dreq->outstanding++;
> +		spin_unlock(&dreq->lock);

Locking.

Deliberate?

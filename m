Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWEKErD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWEKErD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 00:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWEKErD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 00:47:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751463AbWEKErB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 00:47:01 -0400
Date: Wed, 10 May 2006 21:44:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v9fs: signal handling fixes
Message-Id: <20060510214410.4d5bfa15.akpm@osdl.org>
In-Reply-To: <20060506191726.GB8063@ionkov.net>
References: <20060506191726.GB8063@ionkov.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latchesar Ionkov <lucho@ionkov.net> wrote:
>
> +	/* if the request is not sent yet, just remove it from the list */
>  +	list_for_each_entry_safe(rreq, rptr, &m->unsent_req_list, req_list) {
>  +		if (rreq->tag == req->tag) {
>  +			dprintk(DEBUG_MUX, "mux %p req %p request is not sent yet\n", m, req);
>  +			list_del(&rreq->req_list);
>  +			req->flush = Flushed;
>  +			spin_unlock(&m->lock);
>  +			if (req->cb)
>  +				(*req->cb) (req, req->cba);
>  +			return 0;
>  +		}

Actually, list_for_each() would suffice here - the code won't touch the
list again after having modified it.


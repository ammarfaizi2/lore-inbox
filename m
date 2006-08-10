Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWHJA30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWHJA30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWHJA30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:29:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932446AbWHJA3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:29:25 -0400
Date: Wed, 9 Aug 2006 17:29:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: stelian@popies.net, linux-kernel@vger.kernel.org, paulus@au1.ibm.com,
       anton@au1.ibm.com, open-iscsi@googlegroups.com, pradeep@us.ibm.com,
       mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-Id: <20060809172910.614ad979.akpm@osdl.org>
In-Reply-To: <20060810001823.GA3026@us.ibm.com>
References: <20060810001823.GA3026@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 17:18:23 -0700
"Paul E. McKenney" <paulmck@us.ibm.com> wrote:

> @@ -129,6 +129,8 @@ unsigned int __kfifo_put(struct kfifo *f
>  	/* then put the rest (if any) at the beginning of the buffer */
>  	memcpy(fifo->buffer, buffer + l, len - l);
>  
> +	smp_wmb();
> +
>  	fifo->in += len;
>  
>  	return len;
> @@ -161,6 +163,8 @@ unsigned int __kfifo_get(struct kfifo *f
>  	/* then get the rest (if any) from the beginning of the buffer */
>  	memcpy(buffer + l, fifo->buffer, len - l);
>  
> +	smp_mb();
> +
>  	fifo->out += len;
>  
>  	return len;

When adding barriers, please also add a little comment explaining what the
barrier is protecting us from.

Often it's fairly obvious, but sometimes it is not, and in both cases it is still
useful to communicate the programmer's intent in this way.

Thanks.

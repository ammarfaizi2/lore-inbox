Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUIGWpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUIGWpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUIGWpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:45:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:45029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268728AbUIGWo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:44:56 -0400
Date: Tue, 7 Sep 2004 15:48:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, cmm@us.ibm.com, pbadari@us.ibm.com,
       linuxram@us.ibm.com
Subject: Re: [Patch 4/6]: ext3 reservations: Turn ext3 per-sb reservations
 list into an rbtree.
Message-Id: <20040907154833.4cc8d7a3.akpm@osdl.org>
In-Reply-To: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
References: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Tweedie <sct@redhat.com> wrote:
>
>  struct reserve_window {
> -	struct list_head 	rsv_list;
> -	__u32			rsv_start;
> -	__u32			rsv_end;
> +	struct rb_node	 	rsv_node;
> +	__u32			rsv_start;	/* First byte reserved */
> +	__u32			rsv_end;	/* Last byte reserved or 0 */
>  	atomic_t		rsv_goal_size;
>  	__u32			rsv_alloc_hit;
>  };

Takes this structure up to 32 bytes on x86.  That's a moderate amount of
inode bloat for something which is only used when an application currently
has the inode open for writing.

Have you given any thought to dynamic allocation of the above?

And if we were to do that, there are a few things which we could move out
of the ext3 in-core inode and into the above structure, such as
i_next_alloc_block and i_next_alloc_goal.

Does the reservation code work for directory growth, btw?

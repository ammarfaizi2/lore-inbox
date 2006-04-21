Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWDUA65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWDUA65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWDUA65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:58:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932190AbWDUA64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:58:56 -0400
Date: Thu, 20 Apr 2006 17:57:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] FS-Cache: CacheFiles: A cache that backs onto a
 mounted filesystem
Message-Id: <20060420175748.64f592c0.akpm@osdl.org>
In-Reply-To: <20060420165941.9968.13602.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165941.9968.13602.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> +		/* let keventd have some air occasionally */
>  +		max--;
>  +		if (max < 0 || need_resched()) {
>  +			if (!list_empty(&object->read_list))
>  +				schedule_work(&object->read_work);
>  +			_leave(" [maxed out]");
>  +			return;
>  +		}

That's perhaps not a terribly effective way of multiplexing keventd cycles.
If someone has done a schedule_work(), that will stick an entry onto
keventd's worklist, but it won't necessarily set need_resched().

We'd need to extend the workqueue API to be able to determine whether
there's other work pending.

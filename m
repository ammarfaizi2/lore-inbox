Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTIPI0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTIPI0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:26:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:29325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261797AbTIPI0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:26:10 -0400
Date: Tue, 16 Sep 2003 01:26:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, jgarzik@pobox.com,
       jakub@redhat.com
Subject: Re: Add function attribute to copy_from_user to warn for unchecked
 results
Message-Id: <20030916012632.2fb67701.akpm@osdl.org>
In-Reply-To: <20030916100729.B19768@devserv.devel.redhat.com>
References: <20030916100729.B19768@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> Hi,
> 
> gcc 3.4 (CVS) has a new function attribute (warn_unused_result) that
> will make gcc spit out a warning in the event that a "marked" function's
> result is ignored by the caller.

Nice.

> +/* warning: this function has no way to return -EFAULT on bad userspace access */
>  static inline
>  void set_fd_set(unsigned long nr, void __user *ufdset, unsigned long *fdset)
>  {
> +	int dummy;
>  	if (ufdset)
> -		__copy_to_user(ufdset, fdset, FDS_BYTES(nr));
> +		dummy = __copy_to_user(ufdset, fdset, FDS_BYTES(nr));
>  }
>  

Wouldn't it be neater to make this return the __copy_to_user() result?  And
to mark it __must_check?  And to fix the bug you just found in
sys_select()?  ;)

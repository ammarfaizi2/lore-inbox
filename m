Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269636AbUJFXcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbUJFXcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUJFXZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:25:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:63431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269610AbUJFXWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:22:35 -0400
Date: Wed, 6 Oct 2004 16:26:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Serge Hallyn <serue@us.ibm.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, serue@us.ibm.com
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-Id: <20041006162620.4c378320.akpm@osdl.org>
In-Reply-To: <1097094270.6939.9.camel@serge.austin.ibm.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com>
	<1097094270.6939.9.camel@serge.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Hallyn <serue@us.ibm.com> wrote:
>
> 
> Attached is a patch against the security Kconfig and Makefile to support
> bsdjail, as well as the bsdjail.c file itself. bsdjail offers
> functionality similar to (but more limited than) the vserver patch.

I don't recall anyone requesting this feature.  Tell me why we should add
it to Linux?

> +
> +#define in_use(x) (x->jail_flags & IN_USE)
> +#define set_in_use(x) (x->jail_flags |= IN_USE)
> +
> +#define got_network(x) (x->jail_flags & (GOT_IPV4 | GOT_IPV6))
> +#define got_ipv4(x) (x->jail_flags & (GOT_IPV4))
> +#define got_ipv6(x) (x->jail_flags & (GOT_IPV6))
> +#define set_ipv4(x) (x->jail_flags |= GOT_IPV4)
> +#define set_ipv6(x) (x->jail_flags |= GOT_IPV6)
> +#define unset_got_ipv4(x) (x->jail_flags &= ~GOT_IPV4)
> +#define unset_got_ipv6(x) (x->jail_flags &= ~GOT_IPV6)
> +#define get_task_security(task) (task->security)
> +#define get_inode_security(inode) (inode->i_security)
> +#define get_sock_security(sock) (sock->sk_security)
> +#define get_file_security(file) (file->f_security)
> +#define get_ipc_security(ipc)	(ipc->security)
> +#define jail_of(proc) (get_task_security(proc))
> +

The above tricks may make the code easier to type, but I find they make the
code harder for others to read, and that's more important.  We prefer to
open-code such things.

> +	if (tsec->root_pathname)
> +		kfree(tsec->root_pathname);
> +	if (tsec->ip4_addr_name)
> +		kfree(tsec->ip4_addr_name);
> +	if (tsec->ip6_addr_name)
> +		kfree(tsec->ip6_addr_name);

kfree(0) is permitted.  Some people like to do the double test anyway but I
don't think it adds much here.

> +		set_task_security(task,NULL);

whitespace nit: In some places you have spaces after the commas and in
others you do not.

> +	kref_put(&tsec->kref, release_jail);

This is the preferred style.


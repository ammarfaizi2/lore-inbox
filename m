Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUHaDpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUHaDpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 23:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUHaDpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 23:45:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:19181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266459AbUHaDpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 23:45:30 -0400
Date: Mon, 30 Aug 2004 20:43:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-Id: <20040830204332.24da5615.akpm@osdl.org>
In-Reply-To: <200408310325.i7V3Pklo020920@magilla.sf.frob.com>
References: <200408310325.i7V3Pklo020920@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> This patch is against Linus's current tree.

It clashes significantly with your waitid syscall patch.  Which one do you
believe has priority?

> +	info.si_status = tsk->exit_code & 0x7f;
>  		if (tsk->exit_code & 0x80)
> -			why = CLD_DUMPED;
> +		info.si_code = CLD_DUMPED;
>  		else if (tsk->exit_code & 0x7f)
> -			why = CLD_KILLED;
> +		info.si_code = CLD_KILLED;
>  		else {
> -			why = CLD_EXITED;
> -			status = tsk->exit_code >> 8;
> -		}
> -		break;
> +		info.si_code = CLD_EXITED;
> +		info.si_status = tsk->exit_code >> 8;

Indenting catastrophe in do_notify_parent() needs fixing please.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUJDWEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUJDWEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUJDWCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:02:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:3792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268696AbUJDWA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:00:56 -0400
Date: Mon, 4 Oct 2004 15:04:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml@kcore.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: swsusp: fix suspending with mysqld
Message-Id: <20041004150432.097a0d5d.akpm@osdl.org>
In-Reply-To: <20041004122422.GA2601@elf.ucw.cz>
References: <20041004122422.GA2601@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> mysqld does signal calls in pretty tight loop, and swsusp is not able
> to stop processes in such case. This should fix it. Please apply,
>
> ...
> @@ -2260,6 +2259,8 @@
>  			ret = -EINTR;
>  	}
>  
> +	if (current->flags & PF_FREEZE)
> +		refrigerator(1);
>  	return ret;
>  }

This seems hacky, and arbitrary.  I mean, why add this in
sys_rt_sigtimedwait()?  Because that is the syscall which mysql appears to
use?  What if a different application were to be using a different syscall?
Do we add a refrigerator() call there too?

Or am I missing something?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTENGW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTENGW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:22:56 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:29199 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262210AbTENGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:22:54 -0400
Date: Wed, 14 May 2003 07:35:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@infradead.org>, ch@murgatroid.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030514073538.A2982@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, ch@murgatroid.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <20030513233219.5f39bf33.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513233219.5f39bf33.akpm@digeo.com>; from akpm@digeo.com on Tue, May 13, 2003 at 11:32:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 11:32:19PM -0700, Andrew Morton wrote:
>  asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
>  		struct compat_timespec *utime)
>  {
> +#ifdef CONFIG_FUTEX
>  	struct timespec t;
>  	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
>  
> @@ -225,6 +224,9 @@ asmlinkage long compat_sys_futex(u32 *ua
>  		timeout = timespec_to_jiffies(&t) + 1;
>  	}
>  	return do_futex((unsigned long)uaddr, op, val, timeout);
> +#else
> +	return -ENOSYS;
> +#endif

Please make compat_sys_futex a cond_syscall, too.


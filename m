Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUJEFX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUJEFX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUJEFX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:23:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:30181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268778AbUJEFX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:23:26 -0400
Date: Mon, 4 Oct 2004 22:20:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       clameter@sgi.com
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
Message-Id: <20041004222059.5e9ca9f6.akpm@osdl.org>
In-Reply-To: <200410050515.i955Fa15004063@magilla.sf.frob.com>
References: <200410050515.i955Fa15004063@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> +int posix_cpu_clock_settime(clockid_t which_clock,
>  +			    const struct timespec __user *tp)
>  +{
>  +	/*
>  +	 * You can never reset a CPU clock, but we check for other errors
>  +	 * in the call before failing with EPERM.
>  +	 */
>  +	int error = check_clock(which_clock);
>  +	if (error == 0) {
>  +		struct timespec new_tp;
>  +		error = -EPERM;
>  +		if (copy_from_user(&new_tp, tp, sizeof *tp))
>  +			error = -EFAULT;
>  +	}
>  +	return error;
>  +}

This will always return an error.

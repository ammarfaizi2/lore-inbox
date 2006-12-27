Return-Path: <linux-kernel-owner+w=401wt.eu-S1754803AbWL0X0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbWL0X0G (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbWL0X0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 18:26:06 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:60563 "EHLO smTp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754803AbWL0X0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 18:26:05 -0500
Date: Thu, 28 Dec 2006 00:25:55 +0100
From: Vincent Legoll <vlegoll@9online.fr>
Subject: Re: [patch 1/4] Add <linux/klog.h>
In-reply-to: <20061224202628.820320038@panix.com>
To: Zack Weinberg <zackw@panix.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Message-id: <45930103.403@9online.fr>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
References: <20061224202207.150596681@panix.com>
 <20061224202628.820320038@panix.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Weinberg wrote:
> This patch introduces <linux/klog.h> with symbolic constants for the
> various sys_syslog() opcodes, and changes all in-kernel references to
> those opcodes to use the constants.  The header is added to the set of
> user/kernel interface headers.

[...]

> -/*
> - * Commands to do_syslog:
> +/**
> + * do_syslog - operate on the log of kernel messages
> + * @type: operation to perform
> + * @buf: user-space buffer to copy data into
> + * @len: number of bytes of space available at @buf
> + *
> + * See include/linux/klog.h for the command numbers passed as @type.
> + * The @buf and @len parameters are used with the above meanings for
> + * @type values %KLOG_READ, %KLOG_READ_HIST and %KLOG_READ_CLEAR_HIST.
> + * @len is reused with a different meaning, and @buf ignored, for
> + * %KLOG_SET_CONSOLE_LVL.  Both @buf and @len are ignored for all
> + * other @type values.
>   *
> - * 	0 -- Close the log.  Currently a NOP.
> - * 	1 -- Open the log. Currently a NOP.
> - * 	2 -- Read from the log.
> - * 	3 -- Read all messages remaining in the ring buffer.
> - * 	4 -- Read and clear all messages remaining in the ring buffer
> - * 	5 -- Clear ring buffer.
> - * 	6 -- Disable printk's to console
> - * 	7 -- Enable printk's to console
> - *	8 -- Set level of messages printed to console
> - *	9 -- Return number of unread characters in the log buffer
> - *     10 -- Return size of the log buffer
> + * On failure, returns a negative errno code.  On success, returns a
> + * nonnegative integer whose meaning depends on @type.
>   */
>  int do_syslog(int type, char __user *buf, int len)
>  {
> @@ -190,11 +192,11 @@

That part looks good to me, and the kernel-doc hunks from
"[patch 3/4] Refactor do_syslog interface"
too, are:

Acked-by: Vincent Legoll <vincent.legoll@gmail.com>

thanks for handling that.

-- 
Vincent Legoll

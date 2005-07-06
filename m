Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVGFQU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVGFQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGFQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:18:41 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:34380 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262270AbVGFMBt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:01:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HAjWq6hY6K67Lp1CISIxuycTwsmKsI2jfA12UZtjFFO47Mf8Q7HycyegNuEyeC8VyzcfEbRXRbhUCqtRo7wEKh18qysAwIGODv7SdTtSYChkPhlgCqqnJW6ywla+J5ck/AiKUT3T5cjAGNlQsX50Da1nJnwKXEs7mKUFOJCAAXQ=
Message-ID: <84144f0205070605012517003a@mail.gmail.com>
Date: Wed, 6 Jul 2005 15:01:45 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [37/48] Suspend2 2.1.9.8 for 2.6.12: 613-pageflags.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164434190@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164434190@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 614-plugins.patch-old/kernel/power/suspend2_core/plugins.c 614-plugins.patch-new/kernel/power/suspend2_core/plugins.c
> --- 614-plugins.patch-old/kernel/power/suspend2_core/plugins.c  1970-01-01 10:00:00.000000000 +1000
> +++ 614-plugins.patch-new/kernel/power/suspend2_core/plugins.c  2005-07-04 23:14:19.000000000 +1000
> @@ -0,0 +1,341 @@
> +#define FILTER_PLUGIN 1
> +#define WRITER_PLUGIN 2
> +#define MISC_PLUGIN 4 // Block writer, eg.
> +#define CHECKSUM_PLUGIN 5
> +
> +#define SUSPEND_ASYNC 0
> +#define SUSPEND_SYNC  1

Enums are preferred.

> +
> +#define SUSPEND_COMMON_IO_OPS \
> +       /* Writing the image proper */ \
> +       int (*write_chunk) (struct page * buffer_page); \
> +\
> +       /* Reading the image proper */ \
> +       int (*read_chunk) (struct page * buffer_page, int sync); \
> +\
> +       /* Reset plugin if image exists but reading aborted */ \
> +       void (*noresume_reset) (void);

Please remove the above macro obfuscation.

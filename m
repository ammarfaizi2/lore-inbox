Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWE0Skf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWE0Skf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWE0Skf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 14:40:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:6504 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964930AbWE0Ske (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 14:40:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VgwIW1eJvc/dtzb/J3y5HiamHWHv50kzyzwmKq5m8YMyv8kDCJ5EORKAXkD2ZTL8+H4SBbHWcm/5g4FVa86zN00rnCfWVSTAP9iUK8LIq/4C5n7IYUTA0Vz5pJO12YiD5HiBagge5Y8O8eb0rrltztjt0u6KB9+Cqt9BZZ9omWE=
Message-ID: <44789D3D.3020001@gmail.com>
Date: Sat, 27 May 2006 14:41:01 -0400
From: Anne Thrax <foobarfoobarfoobar@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc5 1/7] Base support for kmemleak
References: <20060527120709.21451.3187.stgit@localhost.localdomain> <20060527122307.21451.84934.stgit@localhost.localdomain>
In-Reply-To: <20060527122307.21451.84934.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 mm/memleak.c: In function `insert_pointer':
 mm/memleak.c:216: warning: unused variable `i'
 mm/memleak.c: At top level:
 mm/memleak.c:586: warning: 'memleak_scan' defined but not used

> +/* Insert a pointer and its aliases into the pointer radix tree */
> +static inline void insert_pointer(unsigned long ptr, size_t size, int ref_count)
> +{
> +	struct memleak_alias *alias;
> +	struct hlist_node *elem;
> +	struct memleak_pointer *pointer;
> +	int err, i;
> +#ifdef CONFIG_FRAME_POINTER
> +	void *frame;
> +#endif

If I'm not mistaken, you don't use 'i' outside of #ifdef CONFIG_FRAME_POINTER code.

> +/* Scan the memory and print the orphan pointers */
> +static void memleak_scan(void)

I don't think this is used anywhere in memleak.c besides
#ifdef CONFIG_DEBUG_FS code.

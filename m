Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUBZGYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUBZGYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:24:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2444 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262704AbUBZGXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:23:55 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Early memory patch, revised
References: <403ADCDD.8080206@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Feb 2004 23:16:00 -0700
In-Reply-To: <403ADCDD.8080206@zytor.com>
Message-ID: <m11xoifjrz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> Hi all,

While looking and understanding what this code does I have found
a real bug.

> +/* 
> + * This is how much memory *in addition to the memory covered up to
> + * and including _end* we need mapped initially.  We need one bit for
> + * each possible page, which currently means 2^36/4096/8 = 2 MB
> + * (64-bit-capable chips can do more, but if you have more than 64 GB
> + * of memory you *really* should be running a 64-bit kernel.  However,
> + * if this really bothers someone we could query this dynamically.)
> + *
> + * The other thing we may want to do dynamically in the future is to
> + * detect PSE and skip generating the PTEs.
> + *
> + * Modulo rounding, each megabyte assigned here requires a kilobyte of
> + * memory, which is currently unreclaimed.
> + *
> + * This should be a multiple of a page.
>   */

The comment about the bootmem is wrong and misleading.  The bootmem
bitmap only included low memory.  So in the worst case with a 4G/4G split
it can be 2^32/4096/8 = 128KiB.  Normally the worst case is only 32KiB with
a 3G/1G split.

> +#define INIT_MAP_BEYOND_END	(2*1024*1024)

#define INIT_MAP_BEYOND_END (128*1024)
is the correct value here.

Eric

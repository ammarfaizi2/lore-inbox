Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992625AbWJTQWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992625AbWJTQWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWJTQWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:22:14 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:61757 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932268AbWJTQWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:22:13 -0400
Message-ID: <4538F7B3.4020207@mvista.com>
Date: Fri, 20 Oct 2006 09:22:11 -0700
From: Kevin Hilman <khilman@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab debug and ARCH_SLAB_MINALIGN don't get along
References: <11612878321443-git-send-email-khilman@mvista.com> <84144f020610200156t1745b3d6xee0b0a24e6a1bba5@mail.gmail.com>
In-Reply-To: <84144f020610200156t1745b3d6xee0b0a24e6a1bba5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

> On 10/19/06, Kevin Hilman <khilman@mvista.com> wrote:
>> When CONFIG_SLAB_DEBUG is used in combination with ARCH_SLAB_MINALIGN,
>> some debug flags should be disabled which depend on BYTES_PER_WORD
>> alignment.
>>
>> The disabling of these debug flags is not properly handled when
>> BYTES_PER_WORD < ARCH_SLAB_MEMALIGN < cache_line_size()
>>
>> This patch fixes that and also adds an alignment check to
>> cache_alloc_debugcheck_after() when ARCH_SLAB_MINALIGN is used.
> 
> You forgot to mention which case you are fixing in the patch
> description (that is, SLAB_HWCACHE_ALIGN, when cache_line_size() >
> BYTES_PER_WORD) which made the patch bit hard to decipher. Anyway,
> looks good, thanks!

Hi Pekka,

I found this on an ARM platform where ARCH_SLAB_MINALIGN=8, and the
default SLAB_HWCACHE_ALIGN is set also.

The ARM EABI requires 8-byte alignment to take full advantage of 8-byte
loads/stores for ARM arch >= v5.

Kevin

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWFLRcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWFLRcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFLRcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:32:41 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:42000 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750725AbWFLRck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:32:40 -0400
Message-ID: <448DA530.7050604@shadowen.org>
Date: Mon, 12 Jun 2006 18:32:32 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
References: <448D1117.8010407@innova-card.com> <448D9577.3040903@shadowen.org> <cda58cb80606121021w22207ef6yf6dfcbf428b144c3@mail.gmail.com>
In-Reply-To: <cda58cb80606121021w22207ef6yf6dfcbf428b144c3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> Hi Andy
> 
> 2006/6/12, Andy Whitcroft <apw@shadowen.org>:
> 
>>
>> In my mind the positive option is selecting for code supporting EXTREME
>> so it seems to make sense to use that option.
> 
> 
> well I find it confusing because in my mind, something like this seems
> more logical.
> 
> #ifndef CONFIG_SPARSEMEM_STATIC
> static struct mem_section *sparse_index_alloc(int nid)
> {
>        return alloc_bootmem_node(...);
> }
> #else
> static struct mem_section *sparse_index_alloc(int nid)
> {
>        /* nothing to do here, since it has been statically allocated */
>        return 0;
> }
> #endif

But also in this case the code in the first stanza is only applicable to
SPARSEMEM EXTREME, therefore its also logical to say

#ifdef CONFIG_SPARSEMEM_EXTREME
special handling for that mode
#else
normal handling
#endif

Which is what the code currently says right?

-apw

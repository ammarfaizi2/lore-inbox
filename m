Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWFLRWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWFLRWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWFLRWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:22:02 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:48680 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750869AbWFLRWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:22:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=djxINsGlsJw4RKp316luMp19zMS4AUiGAc++wha++ZOkK1TNhPAinf/hfvs4hEXmQl+ypP6vt99dSYAVQ/xEH6YfpuUtXALWhkkGPUMRWGMxvw9nBi34AMcGYCghWqmQEWPGrPzHlWES0TIkAqvJ+JIu9zdaux1KBEKARA7vqhs=
Message-ID: <cda58cb80606121021w22207ef6yf6dfcbf428b144c3@mail.gmail.com>
Date: Mon, 12 Jun 2006 19:21:59 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Andy Whitcroft" <apw@shadowen.org>
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <448D9577.3040903@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448D1117.8010407@innova-card.com> <448D9577.3040903@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

2006/6/12, Andy Whitcroft <apw@shadowen.org>:
>
> In my mind the positive option is selecting for code supporting EXTREME
> so it seems to make sense to use that option.

well I find it confusing because in my mind, something like this seems
more logical.

#ifndef CONFIG_SPARSEMEM_STATIC
static struct mem_section *sparse_index_alloc(int nid)
{
        return alloc_bootmem_node(...);
}
#else
static struct mem_section *sparse_index_alloc(int nid)
{
        /* nothing to do here, since it has been statically allocated */
        return 0;
}
#endif

This code only deals with section allocation and the way it's achieved
depends only if the section array has been statically allocated.
There's nothing related on the two-level lookups here, is there ?

And use SPARSEMEM_EXTREME when it deals only with two-level lookups:

#ifdef CONFIG_SPARSEMEM_EXTREME
#define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
#else
#define SECTIONS_PER_ROOT       1
#endif

> Perhaps the confusion
> comes from a lack of comments there to say that the else case is STATIC.
>

nope but maybe a comment to explain why i386 use SPARSEMEM_STATIC
option could be useful. At least for someone who is not working on
this arch...

Thanks
-- 
               Franck

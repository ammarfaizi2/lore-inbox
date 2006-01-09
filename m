Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWAIUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWAIUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWAIUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:48:28 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:43930 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751334AbWAIUs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:48:27 -0500
Message-ID: <43C2CB3E.3070208@cs.wisc.edu>
Date: Mon, 09 Jan 2006 14:44:46 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Doug Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm
References: <20060107052221.61d0b600.akpm@osdl.org>  <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>  <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>  <20060109175748.GD25102@redhat.com>  <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>  <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>  <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com>  <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com> <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com> <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> 
> --- 2.6.15-mm2/drivers/scsi/sg.c	2006-01-07 14:05:49.000000000 +0000
> +++ linux/drivers/scsi/sg.c	2006-01-09 20:03:59.000000000 +0000
> @@ -2493,7 +2493,7 @@ sg_page_malloc(int rqSz, int lowDma, int
>  	}
>  	if (resp) {
>  		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
> -			memset(resp, 0, resSz);
> +			memset(page_address(resp), 0, resSz);
>  		if (retSzp)
>  			*retSzp = resSz;
>  	}

Oops yeah, that is right. We switched from __get_free_pages to alloc_pages.

Will alloc_pages() always return lowmem pages or can it return highmem 
pages? Just wondering becuase I guess if it can return highmem pages I 
need to replace the page_adress calls to kmap/kunmap ones right?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935606AbWLDKTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935606AbWLDKTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935631AbWLDKTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:19:33 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:30067 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S935606AbWLDKTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:19:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=loORQJRMfs4g7JMWx9hTk/U0S2dg9KBQVS7VzCKJSWreQrpoEnwhCM0NbZ40VUe+BiQI5bhl38M2RvB11C2cJcXDPqAJAnnzhC3dPUTM27HjlN+wp8ujTH9TzgPJ1LLm0p9HPaa7+kCBmjghAbEmk8oOXWoCeHky+OjahRF3BkI=  ;
X-YMail-OSG: uVSafhgVM1n4.HSHm9zIzPMQZfxqxw7dkSd49jx.toX0o0jJMVSV1kw54hUUKWs.m7Tm_pIZWoADZBo_8i4_bvuP9baiMfiOf9CKP4WGLFMhlZBL5Dzc8mFBd69u4KyDvo8tpCfsdS2ELzc-
Message-ID: <4573F600.50306@yahoo.com.au>
Date: Mon, 04 Dec 2006 21:18:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
CC: linux-kernel@vger.kernel.org, WU Fengguang <wfg@mail.ustc.edu.cn>,
       Andrew Morton <akpm@google.com>
Subject: Re: radix-tree.c:__lookup_slot() dead code removal
References: <20061203170231.GA20298@janus>
In-Reply-To: <20061203170231.GA20298@janus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
> Most of the code suggests that it is valid to insert a NULL item,
> possibly a zero item with pointer cast. However, in __lookup_slot()
> whether or not the slot is found seems to depend on the actual value
> of the item in one special case. But further on it doesn't make any
> difference so to remove some dead code:
> 
> --- a/lib/radix-tree.c	2006-12-03 13:23:00.000000000 +0100
> +++ b/lib/radix-tree.c	2006-12-03 17:57:03.000000000 +0100
> @@ -319,9 +319,6 @@ static inline void **__lookup_slot(struc
>  	if (index > radix_tree_maxindex(height))
>  		return NULL;
>  
> -	if (height == 0 && root->rnode)
> -		return (void **)&root->rnode;
> -
>  	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
>  	slot = &root->rnode;

I would say it is not valid to insert a NULL item (because NULL
means an unsuccessful lookup, you may as well just delete the
item).

Also, I don't see how this is dead code anyway. height == 0
radix-trees are a special case and do not have a radix_tree_node
at ->rnode.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

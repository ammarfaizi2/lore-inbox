Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWH3TZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWH3TZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWH3TZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:25:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:28342 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751362AbWH3TZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:25:30 -0400
Subject: Re: [ckrm-tech] [PATCH 6/7] BC: kernel memory (core)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matt Helsley <matthltc@us.ibm.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44F45601.9060807@sw.ru>
References: <44F45045.70402@sw.ru>  <44F45601.9060807@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Wed, 30 Aug 2006 12:25:26 -0700
Message-Id: <1156965926.12403.51.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 18:58 +0400, Kirill Korotaev wrote:
> --- ./include/bc/beancounter.h.bckmem	2006-08-28 12:47:52.000000000 +0400
> +++ ./include/bc/beancounter.h	2006-08-28 12:59:28.000000000 +0400
> @@ -12,7 +12,9 @@
>   *	Resource list.
>   */
>  
> -#define BC_RESOURCES	0
> +#define BC_KMEMSIZE	0
> +
> +#define BC_RESOURCES	1

<snip>

> --- ./kernel/bc/beancounter.c.bckmem	2006-08-28 12:52:11.000000000 +0400
> +++ ./kernel/bc/beancounter.c	2006-08-28 12:59:28.000000000 +0400
> @@ -20,6 +20,7 @@ static void init_beancounter_struct(stru
>  struct beancounter init_bc;
>  
>  const char *bc_rnames[] = {
> +	"kmemsize",	/* 0 */
>  };
>  
>  static struct hlist_head bc_hash[BC_HASH_SIZE];
> @@ -221,6 +222,8 @@ static void init_beancounter_syslimits(s
>  {
>  	int k;
>  
> +	bc->bc_parms[BC_KMEMSIZE].limit = 32 * 1024 * 1024;
> +
>  	for (k = 0; k < BC_RESOURCES; k++)
>  		bc->bc_parms[k].barrier = bc->bc_parms[k].limit;
>  }

As I mentioned in one of my earlier email
(http://marc.theaimsgroup.com/?l=linux-kernel&m=115619384500289&w=2),
IMHO, this way of defining an interface is not clean/clear (for
controller writers).

<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWIFNzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWIFNzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWIFNzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:55:38 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40635 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751045AbWIFNzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:55:37 -0400
Message-ID: <44FED43B.8050301@sw.ru>
Date: Wed, 06 Sep 2006 17:59:23 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 11/13] BC: vmrss (preparations)
References: <44FD918A.7050501@sw.ru> <44FD9853.6040002@sw.ru> <44FDF5A5.3070608@fr.ibm.com>
In-Reply-To: <44FDF5A5.3070608@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot!!!

> Kirill Korotaev wrote:
> 
> <snip>
> 
>>--- ./include/bc/beancounter.h.bcvmrssprep    2006-09-05
>>13:17:50.000000000 +0400
>>+++ ./include/bc/beancounter.h    2006-09-05 13:44:33.000000000 +0400
>>@@ -45,6 +45,13 @@ struct bc_resource_parm {
>>#define BC_MAXVALUE    LONG_MAX
>>
>>/*
>>+ * This magic is used to distinuish user beancounter and pages beancounter
>>+ * in struct page. page_ub and page_bc are placed in union and MAGIC
>>+ * ensures us that we don't use pbc as ubc in bc_page_uncharge().
>>+ */
>>+#define BC_MAGIC                0x62756275UL
>>+
>>+/*
>> *    Resource management structures
>> * Serialization issues:
>> *   beancounter list management is protected via bc_hash_lock
>>@@ -54,11 +61,13 @@ struct bc_resource_parm {
>> */
>>
>>struct beancounter {
>>+    unsigned long        bc_magic;
>>    atomic_t        bc_refcount;
>>    spinlock_t        bc_lock;
>>    bcid_t            bc_id;
>>    struct hlist_node    hash;
>>
>>+    unsigned long        unused_privvmpages;
>>    /* resources statistics and settings */
>>    struct bc_resource_parm    bc_parms[BC_RESOURCES];
>>};
>>@@ -74,6 +83,8 @@ enum bc_severity { BC_BARRIER, BC_LIMIT,
>>
>>#ifdef CONFIG_BEANCOUNTERS
>>
>>+extern unsigned int nr_beancounters = 1;
>>+
> 
> 
> my gcc doesn't like this one ...
> 
> regards,
> 
> C.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> 
> ---
>  include/bc/beancounter.h |    2 +-
>  kernel/bc/beancounter.c  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: 2.6.18-rc5-mm1/include/bc/beancounter.h
> ===================================================================
> --- 2.6.18-rc5-mm1.orig/include/bc/beancounter.h
> +++ 2.6.18-rc5-mm1/include/bc/beancounter.h
> @@ -86,7 +86,7 @@ enum bc_severity { BC_BARRIER, BC_LIMIT,
> 
>  #ifdef CONFIG_BEANCOUNTERS
> 
> -extern unsigned int nr_beancounters = 1;
> +extern unsigned int nr_beancounters;
> 
>  /*
>   * These functions tune minheld and maxheld values for a given
> Index: 2.6.18-rc5-mm1/kernel/bc/beancounter.c
> ===================================================================
> --- 2.6.18-rc5-mm1.orig/kernel/bc/beancounter.c
> +++ 2.6.18-rc5-mm1/kernel/bc/beancounter.c
> @@ -20,7 +20,7 @@ static void init_beancounter_struct(stru
> 
>  struct beancounter init_bc;
> 
> -unsigned int nr_beancounters;
> +unsigned int nr_beancounters = 1;
> 
>  const char *bc_rnames[] = {
>  	"kmemsize",	/* 0 */
> 


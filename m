Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWIAPd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWIAPd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWIAPd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:33:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:45200 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751410AbWIAPdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:33:55 -0400
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <20060901110908.GB15684@skybase>
References: <20060901110908.GB15684@skybase>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:33:41 -0700
Message-Id: <1157124821.28577.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:09 +0200, Martin Schwidefsky wrote:
> +++ linux-2.6-patched/mm/page_alloc.c   2006-09-01 12:49:35.000000000
> +0200
> @@ -515,6 +515,7 @@ static void __free_pages_ok(struct page 
>                 reserved += free_pages_check(page + i);
>         if (reserved)
>                 return;
> +       page_set_unused(page, order);
>  
>         kernel_map_pages(page, 1 << order, 0);
>         local_irq_save(flags); 

Do these have anything in common with arch_free_page()?  I thought
marking the pages as being "unused by the kernel" was the whole idea of
having that hook.

-- Dave


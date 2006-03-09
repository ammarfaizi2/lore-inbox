Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWCIMEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWCIMEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWCIMD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:03:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751880AbWCIMDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:03:18 -0500
Date: Thu, 9 Mar 2006 04:01:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH: 013/017](RFC) Memory hotplug for new nodes v.3.
 (changes from __init to __meminit)
Message-Id: <20060309040109.4f9c7d5c.akpm@osdl.org>
In-Reply-To: <20060308213446.003C.Y-GOTO@jp.fujitsu.com>
References: <20060308213446.003C.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> Index: pgdat6/include/linux/bootmem.h
>  ===================================================================
>  --- pgdat6.orig/include/linux/bootmem.h	2006-03-06 18:25:37.000000000 +0900
>  +++ pgdat6/include/linux/bootmem.h	2006-03-06 21:08:05.000000000 +0900
>  @@ -88,8 +88,8 @@ static inline void *alloc_remap(int nid,
>   }
>   #endif
>   
>  -extern unsigned long __initdata nr_kernel_pages;
>  -extern unsigned long __initdata nr_all_pages;
>  +extern unsigned long __meminitdata nr_kernel_pages;
>  +extern unsigned long __meminitdata nr_all_pages;

Declaring the section for externs like this isn't very useful really.  I
don't think there's any way in which the compiler can check it and the
linker will look at the definition, not at the declarations.  And if we add
these, we just need to keep the declarations updated for cosmetic reasons
as you've discovered.

So I'd recommend you simply remove the __initdata tags here and leave it at
that.


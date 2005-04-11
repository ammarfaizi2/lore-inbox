Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVDKIYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVDKIYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVDKIYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:24:48 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:52490 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S261727AbVDKIYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:24:41 -0400
X-ME-UUID: 20050411082439797.C2C2C1C000B7@mwinf1103.wanadoo.fr
Message-ID: <425A33DB.1060302@innova-card.com>
Date: Mon, 11 Apr 2005 10:22:51 +0200
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootmem.c clean up bad pfn convertions
References: <425687DB.4000205@innova-card.com> <1113004359.16633.6.camel@localhost>
In-Reply-To: <1113004359.16633.6.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>The only arch with phys_to_pfn() defined is UML, so the patch simply
>won't compile anything but UML on current kernels (unless I'm missing
>something).
>  
>
oops, I forgot to send the part of the patch that defines these macros, 
sorry.

>Could you try to give us a more complete description of your problem?  I
>know your memory doesn't start at 0x0, but what problems does that
>cause?  Does the mem_map[] allocation blow up, etc...  
>  
>
yes, it actually intends to solve that.

>If it's just mem_map[], That calculation could be fixed pretty easily.
>Something like
>
>+#ifdef CONFIG_CRAZY_MIPS_FOO_MEM_MAP_START... 
>+extern unsigned long mem_map_start_pfn
>+#else
>+#define mem_map_start_pfn 0UL
>+#endif
>-#define pfn_to_page(pfn)        (mem_map + (pfn))
>+#define pfn_to_page(pfn)        (mem_map + (pfn) - mem_map_start_pfn)
>
>
>  
>
This is another solution indeed...But you will have to define another 
constant which
will be used for virtual to physical address convertion. In my case I have

#define phys_to_pfn(x)        (((x) - PHYS_START) >> PAGE_SHIFT)
#define pa(x)       ((x) - PAGE_OFFSET + PHYS_START)

and "pfn_to_page" stays untouch.
But I expect your solution easier to implement since as you said 
previously no arch
defines "phys_to_pfn".

Thanks

          Franck.

-------------------------------------------------------------------------------
Come to visit Innova Card at CTST (Las Vegas, April 11-14, 2005) on booth 559 
and Cards Asia (Singapore, April 27-29, 2005) on booth 4A04 !

links:
 - www.ctst.com
 - www.worldofcards.biz/2005/cardsa_SG/

-------------------------------------------------------------------------------
This message contains confidential information and is intended only for the
individual named. If you are not the named addressee you should not
disseminate, distribute or copy this e-mail. Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system.
Innova Card will not therefore be liable for the message if modified.


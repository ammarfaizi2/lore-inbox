Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUAITPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUAITPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:15:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:29432 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263637AbUAITPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:15:46 -0500
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ornati@lycos.it, gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
In-Reply-To: <20040108171728.54a72cf7.akpm@osdl.org>
References: <200401021658.41384.ornati@lycos.it>
	 <200401071559.16130.ornati@lycos.it>
	 <1073503421.10018.17.camel@dyn319250.beaverton.ibm.com>
	 <200401072112.35334.ornati@lycos.it>
	 <20040107155729.7e737c36.akpm@osdl.org>
	 <1073610357.12720.20.camel@dyn319250.beaverton.ibm.com>
	 <20040108171728.54a72cf7.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1073675705.14637.8.camel@dyn319250.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jan 2004 11:15:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 17:17, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
 
> > 
> > Well this is my theory, somebody should validate it,
> 
> One megabyte seems like far too litte memory to be triggering the effect
> which you describe.  But yes, the risk is certainly there.
> 
> You could verify this with:
> 
 
I cannot exactly reproduce what Pualo Ornati is seeing.

Pualo: Request you to validate the following,

1) see whether you see a regression with files replacing the 
   cat command in your script with
       dd if=big_file of=/dev/null bs=1M count=256

2) and if you do, check if you see a bunch of 'eek' with Andrew's 
        following patch. (NOTE: without reverting the changes
        in filemap.c)

--------------------------------------------------------------------------

--- 25/mm/filemap.c~a   Thu Jan  8 17:15:57 2004
+++ 25-akpm/mm/filemap.c        Thu Jan  8 17:16:06 2004
@@ -629,8 +629,10 @@ find_page:
                        handle_ra_miss(mapping, ra, index);
                        goto no_cached_page;
                }
-               if (!PageUptodate(page))
+               if (!PageUptodate(page)) {
+                       printk("eek!\n");
                        goto page_not_up_to_date;
+               }
 page_ok:
                /* If users can be writing to this page using arbitrary
                 * virtual addresses, take care about potential aliasing

---------------------------------------------------------------------------


Thanks,
RP




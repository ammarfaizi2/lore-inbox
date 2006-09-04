Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWIDMTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWIDMTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbWIDMTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:19:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:5232 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964848AbWIDMTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:19:33 -0400
Message-ID: <44FC1AAF.8040504@sw.ru>
Date: Mon, 04 Sep 2006 16:23:11 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 6/7] BC: kernel memory (core)
References: <44F45045.70402@sw.ru>  <44F45601.9060807@sw.ru> <1156883382.5408.153.camel@localhost.localdomain>
In-Reply-To: <1156883382.5408.153.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2006-08-29 at 18:58 +0400, Kirill Korotaev wrote:
> 
>>@@ -274,8 +274,14 @@ struct page {
>>        unsigned int gfp_mask;
>>        unsigned long trace[8];
>> #endif
>>+#ifdef CONFIG_BEANCOUNTERS
>>+       union {
>>+               struct beancounter      *page_bc;
>>+       } bc;
>>+#endif
>> }; 
> 
> 
> I know you're probably saving this union for when you put some userspace
> stuff in here or something.  But, for now, it would probably be best
> just to leave it as a plain struct, or even an anonymous union.
> 
> You probably had to use gcc 2 when this was written and couldn't use
> anonymous unions, right?
are you suggesting the code like this:
>>+#ifdef CONFIG_BEANCOUNTERS
>>+       union {
>>+               struct beancounter      *page_bc;
>>+       };
>>+#endif
>> }; 

#define page_bc(page)	((page)->page_bc)
?

> -- Dave
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 


-- 
VGER BF report: H 5.55112e-17

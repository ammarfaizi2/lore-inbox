Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVJZLMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVJZLMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 07:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVJZLMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 07:12:30 -0400
Received: from web35604.mail.mud.yahoo.com ([66.163.179.143]:56227 "HELO
	web35604.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932391AbVJZLM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 07:12:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zErDn2dydwSYMrTmxh6qKXefRGaTYKW4rxktWNgwQlEF/A0JtUn+r2e+rd8dj5jePDxUrAg/xYDkj9uQgK/Nm7OaJCu851aT/mtsHIBUVFy0jMaufub4OMfEienGdATfa3Hwui/jn8BYUrmQFEfzT1hxlLMHGfDml6xctBmsqJY=  ;
Message-ID: <20051026111229.55319.qmail@web35604.mail.mud.yahoo.com>
Date: Wed, 26 Oct 2005 04:12:29 -0700 (PDT)
From: salve vandana <vandanasalve@yahoo.com>
Subject: Re: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
To: salve vandana <vandanasalve@yahoo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051026050627.69339.qmail@web35602.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some more inputs on what i tried to do

Mine system setup is:
2.4.28kernel with 768MBRAM(final configuration will
1G), No Swap Space and the 
Root File system is mounted as initrd, whose size is
around 300MB.

After few hours,the system goes out of memory and
starts killing processes

As the whole system is in-memory file system all the
pages allocated are not freed but are put into active
or inactive page list. 

I increased the watermark value of min,low and high
pages to higher value then the default value to invoke
the kernel thread "kswap", which free's some of the
pages. This is the observation I have. 

Also the kernel is not configured with HIGH_MEM
support but still I can see some page allocation done
from high memmory...this is mine guess from the
following messsage(gfp = 0x1d2)
"__alloc_pages: 0-order allocation failed
(gfp=0x1d2/0"


After 3-4 hours some of the processes get killed.
Given below :

try_to_free_pages_zone
try_to_free_pages_zone
try_to_free_pages_zone
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process cp_test
Received SIGCHLDtry_to_free_pages_zone
cp_test exited (PID = 213).Invalid TFTP URL for
exporting crash-dumps...
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
ry_to_free_pages_zone
try_to_free_pages_zone
try_to_free_pages_zone


How can I avoid this "Out of memory Issue". Does swap
space helps in this case or what is the significance
of having swap space for ramdisk file system.

Your inputs will be of great. Needs to fixup this
issue as soon as possible.

Thanks,
Vandana




		


--- salve vandana <vandanasalve@yahoo.com> wrote:

> Hi,
> 
> I am getting this VM error on
> 2.4.28kernel(RAM-768MB,
> No Swap and the root file system,whose size is
> around
> 300MB is loaded as initrd).
> After the error the processes are getting killed and
> system is rebooted. I am not understanding why the
> MM
> is trying is allocate pages from HIGH Memory
> (gfp=0x1d2/0) when I dont have High memory and the
> kernel is also not enabled to support High memory. I
> have put the printk's to see how kswapd is woken up
> to
> free unused pages because I dont want to run out of
> memory.
> 
> Here is log:
> 
> try_to_free_pages_zone
> try_to_free_pages_zone
> try_to_free_pages_zone
> __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> VM: killing process cp_test
> Received SIGCHLDtry_to_free_pages_zone
> cp_test exited (PID = 213).Invalid TFTP URL for
> exporting crash-dumps...
> __alloc_pages: 0-order allocation failed
> (gfp=0x1f0/0)
> ry_to_free_pages_zone
> try_to_free_pages_zone
> try_to_free_pages_zone
> 
> Thanks,
> Vandana
> 
> 
> 
> 
> 		
> __________________________________ 
> Yahoo! FareChase: Search multiple travel sites in
> one click.
> http://farechase.yahoo.com
> 
> --
> To unsubscribe, send a message with 'unsubscribe
> linux-mm' in
> the body to majordomo@kvack.org.  For more info on
> Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org">
> email@kvack.org </a>
> 



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com

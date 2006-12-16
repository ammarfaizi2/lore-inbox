Return-Path: <linux-kernel-owner+w=401wt.eu-S1422647AbWLPWHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWLPWHy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWLPWHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:07:54 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46192 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422647AbWLPWHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:07:53 -0500
Date: Sat, 16 Dec 2006 23:06:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Divy Le Ray <divy@chelsio.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cxgb3 and 2.6.20-rc1
In-Reply-To: <45846B47.6010609@chelsio.com>
Message-ID: <Pine.LNX.4.61.0612162303390.5411@yvahk01.tjqt.qr>
References: <4580E3D7.3050708@chelsio.com> <Pine.LNX.4.61.0612162007110.5411@yvahk01.tjqt.qr>
 <45846B47.6010609@chelsio.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-2087777651-1166306668=:5411"
Content-ID: <Pine.LNX.4.61.0612162304400.5411@yvahk01.tjqt.qr>
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-2087777651-1166306668=:5411
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0612162304401.5411@yvahk01.tjqt.qr>


On Dec 16 2006 13:55, Divy Le Ray wrote:
>> > A corresponding monolithic patch is posted at the following URL:
>> > http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
>> > 
>> 
>> I was unable to compile this on 2.6.20-rc1, because:
>> 
>>  CC [M]  drivers/net/cxgb3/cxgb3_offload.o
>> drivers/net/cxgb3/cxgb3_offload.c: In function â€˜cxgb_free_memâ€™:
>> drivers/net/cxgb3/cxgb3_offload.c:1004: error: â€˜PKMAP_BASEâ€™ undeclared
>> (first use in this function)
>> 
>> However, line 1004 is:
>> 
>> if (p >= VMALLOC_START && p < VMALLOC_END)
>> 
>> and include/asm/pgtable.h:
>> 
>> # ifdef CONFIG_HIGHMEM
>> # define VMALLOC_END    (PKMAP_BASE-2*PAGE_SIZE)
>> # else
>> # define VMALLOC_END    (FIXADDR_START-2*PAGE_SIZE)
>> # endif
>> 
>> So include/asm/pgtable.h lacks inclusion of include/asm/highmem.h,
>> where PKMAP_BASE is defined. Adding it gives me more compile errors.
>> Not good. Does anyone have a patch to fix that?
>> 
>
> I've never tripped on this. I cannot reproduce it.

Enable CONFIG_HIGHMEM4G or CONFIG_HIGHMEM64G.

> Would you mind trying this:
> add #include <linux/highmem.h> in drivers/net/cxgb3/cxgb3_offload.c 
> and see if it fixes the compilation ?

Yes 'fixes' it.
But such a change seems bogus to me. You are 
using VMALLOC_END, hence you should include the .h file which contains 
VMALLOC_END, and nothing more. Of course there are exceptions to this 
(like getting at elevator.h's stuff by means of inclusion of blkdev.h)


	-`J'
-- 
--1283855629-2087777651-1166306668=:5411--

Return-Path: <linux-kernel-owner+w=401wt.eu-S1161391AbWLPTRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWLPTRn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161397AbWLPTRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 14:17:42 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57754 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161391AbWLPTRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 14:17:42 -0500
Date: Sat, 16 Dec 2006 20:12:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Divy Le Ray <divy@chelsio.com>
cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org, akpm@osdl.org,
       netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cxgb3 and 2.6.20-rc1
In-Reply-To: <4580E3D7.3050708@chelsio.com>
Message-ID: <Pine.LNX.4.61.0612162007110.5411@yvahk01.tjqt.qr>
References: <4580E3D7.3050708@chelsio.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-71474371-1166296375=:5411"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-71474371-1166296375=:5411
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,


On Dec 13 2006 21:40, Divy Le Ray wrote:
>
> A corresponding monolithic patch is posted at the following URL:
> http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

I was unable to compile this on 2.6.20-rc1, because:

  CC [M]  drivers/net/cxgb3/cxgb3_offload.o
drivers/net/cxgb3/cxgb3_offload.c: In function ‘cxgb_free_mem’:
drivers/net/cxgb3/cxgb3_offload.c:1004: error: ‘PKMAP_BASE’ undeclared 
(first use in this function)

However, line 1004 is:

	if (p >= VMALLOC_START && p < VMALLOC_END)

and include/asm/pgtable.h:

	#ifdef CONFIG_HIGHMEM
	# define VMALLOC_END    (PKMAP_BASE-2*PAGE_SIZE)
	#else
	# define VMALLOC_END    (FIXADDR_START-2*PAGE_SIZE)
	#endif

So include/asm/pgtable.h lacks inclusion of include/asm/highmem.h,
where PKMAP_BASE is defined. Adding it gives me more compile errors.
Not good. Does anyone have a patch to fix that?


	-`J'
-- 
--1283855629-71474371-1166296375=:5411--

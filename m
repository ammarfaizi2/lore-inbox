Return-Path: <linux-kernel-owner+w=401wt.eu-S1030334AbWL3Uut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWL3Uut (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 15:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWL3Uut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 15:50:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:16865 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030334AbWL3Uus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 15:50:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hPsvcNgW/kXtHMBCSwh7CnPVzLgIsqHwFIwpbyIL5hIqVd0+26IPULGID2MmCIa3TAlVOLAoLKNQm/joqfrq02ZDJUtw8wAyoMiW3xz+lM+jAei7xCOOw0iPRBrwtqLGaD1k5heWybVG3XdhVRC7htXpQz7pOTzjbayVc/U1ajQ=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Date: Sat, 30 Dec 2006 21:49:35 +0100
User-Agent: KMail/1.8.2
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612302149.35752.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 December 2006 07:16, Robert P. J. Day wrote:
> 
>   is there some reason there are so many calls of the form
> 
>   memset(addr, 0, PAGE_SIZE)
> 
> rather than the apparently equivalent invocation of
> 
>   clear_page(addr)
> 
> the majority of architectures appear to define the clear_page() macro
> in their include/<arch>/page.h header file, but not entirely
> identically, and in some cases that definition is conditional, as with
> i386:
> 
> =============================================================
> #ifdef CONFIG_X86_USE_3DNOW
> ...
> #define clear_page(page)        mmx_clear_page((void *)(page))
> ...
> #else
> ...
> #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
> ...
> #endif
> ============================================================
> 
>   should it perhaps be part of the CodingStyle doc to use the
> clear_page() macro rather than an explicit call to memset()?  (and
> should all architectures be required to define that macro?)

clear_page assumes that given address is page aligned, I think.
It may fail if you feed it with misaligned region's address.
--
vda

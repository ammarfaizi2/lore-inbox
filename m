Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbUKRPe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbUKRPe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUKRPe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:34:58 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:59862 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262469AbUKRPex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:34:53 -0500
Message-ID: <419CC11D.7040303@us.ibm.com>
Date: Thu, 18 Nov 2004 07:34:53 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hariprasad Nellitheertha <hari@in.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vara Prasad <varap@us.ibm.com>
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
References: <419CACE2.7060408@in.ibm.com>
In-Reply-To: <419CACE2.7060408@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hari,

Tested the patch on my 4-way P-III  (where it was hanging earlier)
and it works fine for me.

Thanks,
Badari

Hariprasad Nellitheertha wrote:
> Hi Andrew,
> 
> There was a buggy (and unnecessary) reserve_bootmem call in the kdump 
> call which was causing hangs during early on some SMP machines. The 
> attached patch removes that.
> 
> Kindly include this patch into the -mm tree.
> 
> Thanks and Regards, Hari
> 
> 
> ------------------------------------------------------------------------
> 
> 
> 
> Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
> ---
> 
>  linux-2.6.10-rc2-hari/include/asm-i386/crash_dump.h |    1 -
>  1 files changed, 1 deletion(-)
> 
> diff -puN include/asm-i386/crash_dump.h~kdump-reserve-bootmem-fix include/asm-i386/crash_dump.h
> --- linux-2.6.10-rc2/include/asm-i386/crash_dump.h~kdump-reserve-bootmem-fix	2004-11-18 19:20:47.000000000 +0530
> +++ linux-2.6.10-rc2-hari/include/asm-i386/crash_dump.h	2004-11-18 19:21:03.000000000 +0530
> @@ -37,7 +37,6 @@ static inline void set_saved_max_pfn(voi
>  static inline void crash_reserve_bootmem(void)
>  {
>  	if (!dump_enabled) {
> -		reserve_bootmem(0, CRASH_RELOCATE_SIZE);
>  		reserve_bootmem(CRASH_BACKUP_BASE,
>  			CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE + PAGE_SIZE);
>  	}
> _


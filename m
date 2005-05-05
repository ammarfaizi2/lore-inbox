Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVEECdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVEECdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 22:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVEECdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 22:33:43 -0400
Received: from lixom.net ([66.141.50.11]:53958 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S261822AbVEECde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 22:33:34 -0400
Date: Wed, 4 May 2005 21:31:32 -0500
To: Andy Whitcroft <apw@shadowen.org>
Cc: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com
Subject: Re: [3/3] sparsemem memory model for ppc64
Message-ID: <20050505023132.GB20283@austin.ibm.com>
References: <E1DTQWH-0002We-I9@pinky.shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DTQWH-0002We-I9@pinky.shadowen.org>
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just two formatting nitpicks below.

-Olof

On Wed, May 04, 2005 at 09:30:57PM +0100, Andy Whitcroft wrote:
> diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/mm/init.c current/arch/ppc64/mm/init.c
> --- reference/arch/ppc64/mm/init.c	2005-05-04 20:54:20.000000000 +0100
> +++ current/arch/ppc64/mm/init.c	2005-05-04 20:54:54.000000000 +0100
[...]
> @@ -623,12 +631,18 @@ void __init do_init_bootmem(void)
>  
>  	max_pfn = max_low_pfn;
>  
> -	/* add all physical memory to the bootmem map. Also find the first */
> +	/* add all physical memory to the bootmem map. Also, find the first
> +	 * presence of all LMBs*/

CodingStyle:   */  on new line

>  	for (i=0; i < lmb.memory.cnt; i++) {
>  		unsigned long physbase, size;
>  
>  		physbase = lmb.memory.region[i].physbase;
>  		size = lmb.memory.region[i].size;
> +		if (i) { /* already created mappings for first LMB */
> +			start_pfn = physbase >> PAGE_SHIFT;
> +			end_pfn = start_pfn + (size >> PAGE_SHIFT);

Comment on new line indented, please


-Olof

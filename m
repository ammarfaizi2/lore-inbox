Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263258AbTDBXbK>; Wed, 2 Apr 2003 18:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263259AbTDBXbJ>; Wed, 2 Apr 2003 18:31:09 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:19730 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263258AbTDBXbH>; Wed, 2 Apr 2003 18:31:07 -0500
Date: Wed, 02 Apr 2003 17:42:25 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-ID: <110950000.1049326945@baldur.austin.ibm.com>
In-Reply-To: <20030402153845.0770ef54.akpm@digeo.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
 <20030402132939.647c74a6.akpm@digeo.com>
 <80300000.1049320593@baldur.austin.ibm.com>
 <20030402150903.21765844.akpm@digeo.com>
 <102170000.1049325787@baldur.austin.ibm.com>
 <20030402153845.0770ef54.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, April 02, 2003 15:38:45 -0800 Andrew Morton
<akpm@digeo.com> wrote:

> But:
> 
> +	/* Double check to make sure the pte page hasn't been freed */
> +	if (!pmd_present(*pmd))
> +		goto out_unmap;
> +
> 	==> munmap, pte page is freed, reallocated for pagecache, someone
> 	    happens to write the correct value into it.
> 	
> +	if (page_to_pfn(page) != pte_pfn(*pte))
> +		goto out_unmap;
> +
> +	if (addr)
> +		*addr = address;
> +

Oops.  The pmd_present() check should be after the page_to_pfn() !=
pte_pfn() check.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbTHLPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270724AbTHLPi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:38:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31665 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S270520AbTHLPi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:38:27 -0400
Subject: Re: [patch] 16-way x440 breakage
From: Dave Hansen <haveblue@us.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <3F342CE9.50308@us.ibm.com>
References: <3F342CE9.50308@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060702681.32409.2148.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Aug 2003 08:38:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 16:06, Matthew Dobson wrote:
> +	if ((rth->num_scal_dev > MAX_NUMNODES) || 
> +	    (rth->num_rio_dev > MAX_NUMNODES * 2)){
> +		printk("%s ERROR!  MAX_NUMNODES incorrectly defined as %d!!!\n", __FUNCTION__, MAX_NUMNODES);
> +		return 1;
> +	}

Why don't you actually warn for the real condition?  MAX_NUMNODES isn't
incorrect, it's just too low.  Could you mention that it needs to be
raised, and maybe the value it should be raised to?

>  	ptr = (unsigned long)rth + 3;
> -	for(i = 0; i < rth->num_scal_dev; i++)
> -		sd[i] = (struct scal_detail *)(ptr + (scal_detail_size * i));
> +	for(i = 0; i < rth->num_scal_dev; i++, ptr += scal_detail_size)
> +		sd[i] = (struct scal_detail *)ptr;
> +
> +	for(i = 0; i < rth->num_rio_dev; i++, ptr += rio_detail_size)
> +		rd[i] = (struct rio_detail *)ptr;

All the casting here scares me.  If you're doing this: 
(struct scal_detail *)(ptr + (scal_detail_size * i)
and this:
ptr += scal_detail_size
just make it a struct scal_detail * and be done with it.  If it walks
like a duck...

-- 
Dave Hansen
haveblue@us.ibm.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWGaIer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWGaIer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWGaIer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:34:47 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19904 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750823AbWGaIeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:34:46 -0400
Date: Mon, 31 Jul 2006 17:30:55 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: kmannth@us.ibm.com
Subject: Re: [Lhms-devel] [Patch] 3/5 in support of hot-add memory x86_64 arch_find_node	x86_64
Cc: lkml <linux-kernel@vger.kernel.org>, andrew <akpm@osdl.org>,
       discuss <discuss@x86-64.org>, dave hansen <haveblue@us.ibm.com>,
       Andi Kleen <ak@suse.de>, konrad <darnok@us.ibm.com>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154141562.5874.147.camel@keithlap>
References: <1154141562.5874.147.camel@keithlap>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060731171336.B86E.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urN orig/arch/x86_64/mm/srat.c work/arch/x86_64/mm/srat.c
> --- orig/arch/x86_64/mm/srat.c	2006-07-28 13:57:35.000000000 -0400
> +++ work/arch/x86_64/mm/srat.c	2006-07-28 21:19:01.000000000 -0400
> @@ -450,3 +450,15 @@
>  }
>  
>  EXPORT_SYMBOL(__node_distance);
> +
> +int arch_find_node(unsigned long start, unsigned long size) 
> +{
> +	int i, ret = 0;
> +	unsigned long end = start+size;
> +	
> +	for_each_node(i) {
> +		if (nodes_add[i].start <= start && nodes_add[i].end >= end)
> +			ret = i;
> +	}
> +	return ret;
> +}

BTW, does anyone know why nodes_add[] becomes arch dependent code?

I know it is defined in x86-64. But I mean that SRAT is not
arch dependent. It is defined by just ACPI.
However, each arch which uses ACPI has a own code to parse SRAT table.
Is it hard to merge all of them? Are there any special case?

If they can be merged, this code can be written in driver/acpi/numa.c.


Bye.


-- 
Yasunori Goto 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVKPN0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVKPN0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbVKPN0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:26:04 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:7942 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030324AbVKPN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:26:03 -0500
Message-ID: <437B3349.8050308@shadowen.org>
Date: Wed, 16 Nov 2005 13:25:29 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: linux-mm@kvack.org, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pfn_to_nid under CONFIG_SPARSEMEM and CONFIG_NUMA
References: <20051115221003.GA2160@w-mikek2.ibm.com>
In-Reply-To: <20051115221003.GA2160@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> The following code/comment is in <linux/mmzone.h> if SPARSEMEM
> and NUMA are configured.
> 
> /*
>  * These are _only_ used during initialisation, therefore they
>  * can use __initdata ...  They could have names to indicate
>  * this restriction.
>  */
> #ifdef CONFIG_NUMA
> #define pfn_to_nid              early_pfn_to_nid
> #endif

Ok.  This was a ploy to avoid lots of code churn which has bitten us.
The separation here is to indicate that pfn_to_nid isn't necessarily
safe until after the memory model is init'd.  When the code was
initially implmented we only used pfn_to_nid in init code so it wasn't
an issue.  What we need to do here is break this link and make sure each
user is using the right version.

I'll go and put together something now.

-apw

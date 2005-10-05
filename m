Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVJEWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVJEWDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVJEWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:03:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47847 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030309AbVJEWDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:03:38 -0400
Subject: Re: [PATCH] Free swap suspend from dependency on PageReserved
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128546263.10363.14.camel@localhost>
References: <1128546263.10363.14.camel@localhost>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 15:03:32 -0700
Message-Id: <1128549812.18249.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 07:04 +1000, Nigel Cunningham wrote:
> 
> +       for (tmp = 0; tmp < max_low_pfn; tmp++, addr += PAGE_SIZE) {
> +               if (page_is_ram(tmp)) {
> +                       /*
> +                        * Only count reserved RAM pages
> +                        */
> +                       if (PageReserved(mem_map+tmp))
> +                               reservedpages++;

Please don't reference mem_map[] directly outside of #ifdef
CONFIG_FLATMEM areas.  It is not defined for all config cases.  Please
use pfn_to_page(), instead.  It should work in all cases where the page
is valid.

Also, instead of keeping addr defined like you do, and comparing it
during each run of the loop, why not just use pfn_is_nosave(), which is
already defined?  Then, you won't even need the variable.

-- Dave


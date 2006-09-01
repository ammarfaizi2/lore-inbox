Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWIAPRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWIAPRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWIAPRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:17:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49125 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751510AbWIAPRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:17:32 -0400
Subject: Re: [patch 8/9] Guest page hinting: discarded page list.
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <20060901111117.GI15684@skybase>
References: <20060901111117.GI15684@skybase>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:17:16 -0700
Message-Id: <1157123836.28577.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:11 +0200, Martin Schwidefsky wrote:
> 
> +#if defined(CONFIG_PAGE_DISCARD_LIST)
> +       if (page_host_discards() && unlikely(PageDiscarded(page))) {
> +               local_irq_disable();
> +               list_add_tail(&page->lru,
> +                             &__get_cpu_var(page_discard_list));
> +               local_irq_enable();
> +               return;
> +       }
> +#endif 

If PageDiscarded() was #ifdef'd in the header, you wouldn't need this in
the .c file.

-- Dave


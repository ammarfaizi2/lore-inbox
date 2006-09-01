Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWIAPkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWIAPkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWIAPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:40:23 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:7558 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751652AbWIAPkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:40:22 -0400
Subject: Re: [patch 8/9] Guest page hinting: discarded page list.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157123836.28577.77.camel@localhost.localdomain>
References: <20060901111117.GI15684@skybase>
	 <1157123836.28577.77.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 17:40:19 +0200
Message-Id: <1157125219.21733.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 08:17 -0700, Dave Hansen wrote:
> > +#if defined(CONFIG_PAGE_DISCARD_LIST)
> > +       if (page_host_discards() && unlikely(PageDiscarded(page))) {
> > +               local_irq_disable();
> > +               list_add_tail(&page->lru,
> > +                             &__get_cpu_var(page_discard_list));
> > +               local_irq_enable();
> > +               return;
> > +       }
> > +#endif 
> 
> If PageDiscarded() was #ifdef'd in the header, you wouldn't need this in
> the .c file.

No, unfortunately not. There is a new variable page_discard_list that is
only defined if CONFG_PAGE_DISCARD_LIST is set. The compiler will
complain about the absence of the variable, even if the code is never
reached because PageDiscarded always returns 0.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



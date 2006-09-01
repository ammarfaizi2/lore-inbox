Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWIAPwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWIAPwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWIAPwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:52:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:46721 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751680AbWIAPwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:52:42 -0400
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <1157125031.21733.21.camel@localhost>
References: <20060901111006.GE15684@skybase>
	 <1157123046.28577.75.camel@localhost.localdomain>
	 <1157125031.21733.21.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:52:19 -0700
Message-Id: <1157125939.28577.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 17:37 +0200, Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 08:04 -0700, Dave Hansen wrote:
> > > +EXPORT_SYMBOL(find_get_page_nodiscard);
> > > +
> > > +#endif
> > 
> > Is it worth having another full copy of find_get_page()?  What about a
> > "nodiscard" argument?
> 
> That is a hard call to make. I really tried hard to avoid adding any
> overhead to a system running without the feature.

The overhead being the extra (potentially unused) argument to the
function?  Plus, that the function isn't inlined and thus will be unable
to have its argument optimized away?

In the worse case, we're talking about the cost of saving and restoring
the contents of a single register to the stack.  In other arches, we're
talking about the push of an immediate on the stack for the call.

Yeah, it is a hard call to make, especially if you're aiming for
zero-impact.

-- Dave


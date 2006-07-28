Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751996AbWG1O6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWG1O6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWG1O6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:58:35 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:26941 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751996AbWG1O6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:58:34 -0400
Subject: Re: [patch] bootmem: use MAX_DMA_ADDRESS instead of LOW32LIMIT
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060728131306.GA32513@elte.hu>
References: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com>
	 <20060728131306.GA32513@elte.hu>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 28 Jul 2006 16:58:45 +0200
Message-Id: <1154098725.3211.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 15:13 +0200, Ingo Molnar wrote:
> > -#define LOW32LIMIT 0xffffffff
> 
> >  		if ((ptr = __alloc_bootmem_core(bdata, size,
> > -						 align, goal, LOW32LIMIT)))
> > +						 align, goal, MAX_DMA_ADDRESS)))
> 
> but this limits things to 16MB on i686. Are you sure this wont break 
> anything?

That is something we should not do. MAX_DMA_ADDRESS is not the correct
value, it says something about the DMA limitations. LOW32LIMIT says
something about the cpu addressing limitations which is a completly
different thing. I think it would be best to introduce an architecture
overridable define like LOW_ADDRESS_LIMIT. The default is 4GB-1, for
s390 it is 2GB-1. The current name is misleading LOW32LIMIT indicates
that the address for alloc_bootmem_low objects has 32 bits, which isn't
true for s390.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



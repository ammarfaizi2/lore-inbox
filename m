Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWIFOTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWIFOTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIFOTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:19:22 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:18094 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751139AbWIFOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:19:21 -0400
Subject: Re: lockdep oddity
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Hua Zhong <hzhong@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Arjan van de Ven'" <arjan@infradead.org>
In-Reply-To: <20060906084021.GA30856@elte.hu>
References: <20060906080129.GD6898@osiris.boeblingen.de.ibm.com>
	 <004901c6d18d$acc45620$0200a8c0@nuitysystems.com>
	 <20060906084021.GA30856@elte.hu>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 07:19:19 -0700
Message-Id: <1157552359.3541.16.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 10:40 +0200, Ingo Molnar wrote:
> * Hua Zhong <hzhong@gmail.com> wrote:
> 
> > We are just trading accuracy for speed here.
> 
> no, we are trading _both_ accuracy and speed here! a global 'likeliness' 
> pointer for commonly executed codepaths is causing global cacheline 
> ping-pongs - which is as bad as it gets.

Up stream or no, would be better for it to again be light weight.

> the right approach, which incidentally would also be perfectly accurate, 
> is to store an alloc_percpu()-ed pointer at the call site, not the 
> counter itself.

I don't think it could be done via the macro. If it were called during
run time it would have to be special alloc_percpu() that didn't call
back into the profiling code (which almost everything does do).

> the current code needs more work before it can go upstream i think.

It was never really planned to go upstream. It's ultimately a debugging
feature that's really only needed in -mm .. 

Daniel


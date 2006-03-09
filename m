Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWCIL0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWCIL0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWCIL0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:26:52 -0500
Received: from main.gmane.org ([80.91.229.2]:31962 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750886AbWCIL0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:26:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Thu, 09 Mar 2006 14:26:06 +0300
Message-ID: <dup3ct$hvt$1@sea.gmane.org>
References: <31492.1141753245@warthog.cambridge.redhat.com>
	<1141756825.31814.75.camel@localhost.localdomain>
	<Pine.LNX.4.61.0603071346540.9814@chaos.analogic.com>
	<20060307190602.GE7301@parisc-linux.org>
	<Pine.LNX.4.61.0603071408220.9899@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
Cc: linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Tue, 7 Mar 2006, Matthew Wilcox wrote:
>
>> On Tue, Mar 07, 2006 at 01:54:33PM -0500, linux-os (Dick Johnson) wrote:
>>> This might be a good place to document:
>>>     dummy = readl(&foodev->ctrl);
>>>
>>> Will flush all pending writes to the PCI bus and that:
>>>     (void) readl(&foodev->ctrl);
>>> ... won't because `gcc` may optimize it away. In fact, variable
>>> "dummy" should be global or `gcc` may make it go away as well.
>>
>> static inline unsigned int readl(const volatile void __iomem *addr)
>> {
>> 	return *(volatile unsigned int __force *) addr;
>> }
>>
>> The cast is volatile, so gcc knows not to optimise it away.
>>
>
> When the assignment is not made a.k.a., cast to void, or when the
> assignment is made to an otherwise unused variable, `gcc` does,
> indeed make it go away.

Wrong. From the GCC texinfo documentation:

" Less obvious expressions are where something which looks like an access
is used in a void context.  An example would be,

     volatile int *src = SOMEVALUE;
     *src;

 With C, such expressions are rvalues, and as rvalues cause a read of
the object, GCC interprets this as a read of the volatile being pointed
to. "

So, did you report the bug to the GCC maintainers?

-- Sergei.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVK3Qjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVK3Qjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVK3Qjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:39:37 -0500
Received: from smtpout.mac.com ([17.250.248.44]:44022 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751445AbVK3Qjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:39:36 -0500
In-Reply-To: <Pine.LNX.4.58.0511300821570.18317@shark.he.net>
References: <20051130042118.GA19112@kvack.org> <438D4905.9F023405@users.sourceforge.net> <Pine.LNX.4.58.0511300821570.18317@shark.he.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F2C387BC-0B94-4BDC-8918-4B073C221553@mac.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Date: Wed, 30 Nov 2005 11:39:17 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2005, at 11:22:48, Randy.Dunlap wrote:
> On Wed, 30 Nov 2005, Jari Ruusu wrote:
>
>> Benjamin LaHaise wrote:
>>> The following emails contain the patches to convert x86-64 to  
>>> store current
>>> in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).
>> [snip]
>>> No benchmarks that I am aware of show regressions with this change.
>>
>> Ben,
>> Your patch breaks all out-of-tree amd64 assembler code used in  
>> kernel. r10 register is one of those registers that does not need  
>> to be preserved across function calls, and reserving that register  
>> for other purpose means that all assembler code using r10 in  
>> kernel must be rewritten. This is deeply unfunny.
>>
>> Andi,
>> Please don't apply Ben's patch. It is already bad enough having to  
>> deal with two incompatible calling conventions on 32 bit x86.
>
> Just for the sake of understanding the current kernel release  
> process, when would something like this be acceptable/possible?   
> Would it require a Linux 3.0 version, or at least a 2.8?

It's perfectly acceptable in 2.6, assuming it's properly divided up  
into small discrete changes and spends a bit of time in -mm first to  
work out the bugs.  If people want to maintain out-of-tree drivers,  
especially those using assembly, when things break they get to keep  
both pieces.  This patch produces a rather large space savings and  
speeds things up to boot, and I would support it being pushed to  
Linus during the 2.6.16 merge window assuming it stands up to abuse  
in -mm for a bit.

Cheers,
Kyle Moffett


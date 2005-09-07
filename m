Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVIGB73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVIGB73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVIGB73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:59:29 -0400
Received: from orb.pobox.com ([207.8.226.5]:15810 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S1751189AbVIGB73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:59:29 -0400
Message-ID: <431E497A.4080303@rtr.ca>
Date: Tue, 06 Sep 2005 21:59:22 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <58d0dbf10509061005358dce91@mail.gmail.com> <dfkjav$lmd$1@sea.gmane.org> <200509061819.45567.phillips@istop.com>
In-Reply-To: <200509061819.45567.phillips@istop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> There are only two stacks involved, the normal kernel stack and your new ndis 
> stack.  You save ESP of the kernel stack at the base of the ndis stack.  When 
> the Windows code calls your api, you get the ndis ESP, load the kernel ESP 
> from the base of the ndis stack, push the ndis ESP so you can get back to the 
> ndis code later, and continue on your merry way.

With CONFIG_PREEMPT, this will still cause trouble due to lack
of "current" task info on the NDIS stack.

One option is to copy (duplicate) the bottom-of-stack info when
switching to the NDIS stack.

Another option is to stick a Mutex around any use of the NDIS stack
when calling into the foreign driver (might be done like this already??),
which will prevent PREEMPTion during the call.

Cheers

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVAELTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVAELTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVAELTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:19:21 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:39165 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262328AbVAELTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:19:14 -0500
Message-ID: <41DBCD43.2000104@cwazy.co.uk>
Date: Wed, 05 Jan 2005 06:19:31 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Brian Gerst <bgerst@didntduck.org>, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
References: <20050104214048.21749.85722.89116@localhost.localdomain> <41DB4E99.3060200@didntduck.org> <41DB5476.9040103@cwazy.co.uk> <20050105092659.GA27103@lst.de>
In-Reply-To: <20050105092659.GA27103@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Wed, 5 Jan 2005 05:19:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Jan 04, 2005 at 09:44:06PM -0500, Jim Nelson wrote:
> 
>>Brian Gerst wrote:
>>
>>
>>>James Nelson wrote:
>>>
>>>
>>>>This series of patches is to remove the last cli()/sti() function 
>>>>calls in arch/ppc.
>>>>
>>>>These are the only instances in active code that grep could find.
>>>
>>>
>>>Are you sure none of these need real spinlocks instead of just 
>>>disabling interrupts?
>>>
>>>-- 
>>>               Brian Gerst
>>>
>>
>>These are for single-processor systems, mostly evaluation boards and 
>>embedded processors.  I coudn't find any reference to multiprocessor 
>>setups for the processors in question after a peruse of the code or a 
>>quick google on the boards in question.
> 
> 
> think CONFIG_PREEMPT.  In either case a spinlock becomes
> lock_irq_disable in the !SMP, !PREEMPT case but it documents the
> intention a whole lot better.
> 
> Also you're locking only in a single plpace which is a ***BIG*** warning
> sign.  At least look at the other users of the data structure, it's
> extremly likely they'll need locking aswell.
> 

Some of the cli() uses were in shutdown and IRQ setup code, where you'd just need 
to disable interrupts.  There are a few files that will need a more thourough 
going-through, however.

I'll start checking those later.

Jim

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTDYWcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTDYWcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:32:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:15757 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262710AbTDYWcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:32:41 -0400
Date: Fri, 25 Apr 2003 15:10:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <3600000.1051308616@[10.10.2.4]>
In-Reply-To: <m3sms644zz.fsf@averell.firstfloor.org>
References: <20030425204012$4424@gated-at.bofh.it>
 <m3sms644zz.fsf@averell.firstfloor.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just
>> shove libraries directly above the program text? Red Hat seems to have
>> patches to dynamically tune it on a per-processes basis anyway ...
> 
> Yes. You won't get a continuous sbrk/brk heap then anymore. Not sure it
> is a  big problem though.

Me no understand. I think this *makes* it a contiguous space. The way I see
it, we currently allocate from TASK_UNMAPPED_BASE up to the top, then start
again above program text. Which seems a bit silly.

> It's probably worth a sysctl at least.

mmm. I'd prefer a config option. Defaulting to 'y' ;-)

>> Moreover, can we put the stack back where it's meant to be, below the
>> program text, in that wasted 128MB of virtual space? Who really wants 
>>> 128MB of stack anyway (and can't fix their app)?
> 
> You could, but I bet it would break some programs
> (e.g. just moving __PAGE_OFFSET on amd64 to 4GB for 32bit broke some
> things)

I've moved PAGE_OFFSET around a lot (which moves the stack, as you say). 
Haven't seen it break anything yet ... IMHO it was broken anyway if this
hurts it. Obviously not something one could do in a stable kernel series,
but 2.5 seems like a perfect time for it to me ... unless I'm missing some
glibc / linker thing, it seems like a simple change.

M.


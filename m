Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWHVTnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWHVTnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWHVTnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:43:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31650 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750722AbWHVTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:43:44 -0400
Message-ID: <44EB5E6F.5090001@vmware.com>
Date: Tue, 22 Aug 2006 12:43:43 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain>	 <44DB7596.6010503@goop.org>	 <1156254965.27114.17.camel@localhost.localdomain>	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>	 <1156271386.2976.102.camel@laptopd505.fenrus.org>	 <1156275004.27114.34.camel@localhost.localdomain>	 <44EB584A.5070505@vmware.com>  <44EB5A76.9060402@vmware.com> <1156274983.2976.111.camel@laptopd505.fenrus.org>
In-Reply-To: <1156274983.2976.111.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> That is a really nasty problem.  You need a synchronization primitive 
>> which guarantees a flat stack, so you can't do it in the interrupt 
>> handler as I have tried to do.  I'll bang my head on it awhile.  In the 
>> meantime, were there ever any solutions to the syscall patching problem 
>> that might lend me a clue as to what to do (or not to do, or impossible?).
>>     
>
> yes we just disallowed it :)
>   

Ok, I just took a cold shower.  Actually, this problem is much easier to 
solve for paravirt-ops, since they are short lived operations and don't 
block.  For syscall, it is much, much harder, since you have syscalls 
that can block forever, so you can't guarantee you'll exit all instances 
of the syscall you want to patch.

I think the paravirt-ops one is doable with exports already provided by 
Linux.

Zach

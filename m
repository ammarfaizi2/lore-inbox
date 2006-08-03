Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWHCR56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWHCR56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHCR56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:57:58 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:65250 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964778AbWHCR55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:57:57 -0400
Message-ID: <44D23924.9040704@vmware.com>
Date: Thu, 03 Aug 2006 10:57:56 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com>	 <1154603822.2965.18.camel@laptopd505.fenrus.org> <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
In-Reply-To: <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
> If the essence of using virtual machines is precisely that the machine
> acts just as if it was a real hardware one, then we should not need
> any modifications to the kernel. So, it would be much better if the
> hypervirsor was completely transparent and just emulated a native cpu
> and a common native set of hardware, which would then work 100% with
> the native code in the kernel. This keeps the smarts of virtual
> machine management on the hypervisor.

You are basically arguing for full virtualization - which is fine.  But 
today as it stands it does not provide the highest level of performance 
that paravirtualization does, and in the future, it does little to 
provide more advanced virtualization features.

>
> For example, TBL and pagetable handling can be done with 2 interfaces,
> one standard via intercepting normal cpu instructions, and a batched
> one via a hardware driver with a FIFO on shared memory just like many
> graphics card do to send commands and data to the GPU. I recall this
> design was the one used in the mac-on-linux hypervisor for ppc
> architecture. Why not for x86 with vt/pacifica extensions? What about
> using the same design than on the Sparc T1 port?

You can't use a driver to do this in Linux today, because there are no 
hooks you can use for pagetable handling.  And you will always achieve 
better performance and simplicity by changing the machine definition to 
avoid the really nasty cases.  Hardware virtualization is simply not 
fast enough today.  But it also doesn't leave room for the future - 
proposals such as the abstract MMU interfaces for Linux which have been 
floating around are extremely attractive from a hypervisor point of view 
- but there can be no progress until there is some kind of consensus on 
what those are, and having an interface in the kernel is a requirement 
for any deeper level of paravirtualization.

Zach


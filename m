Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWHVTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWHVTRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWHVTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:17:32 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:43737 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751151AbWHVTRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:17:31 -0400
Message-ID: <44EB584A.5070505@vmware.com>
Date: Tue, 22 Aug 2006 12:17:30 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@muc.de>,
       virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain>	 <44DB7596.6010503@goop.org>	 <1156254965.27114.17.camel@localhost.localdomain>	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>	 <1156271386.2976.102.camel@laptopd505.fenrus.org> <1156275004.27114.34.camel@localhost.localdomain>
In-Reply-To: <1156275004.27114.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> - Stacked hypervisors stomping each others functions
>   

Possibly an issue, but why would you ever want stacked paravirt-ops?  
You're only talking to the hypervisor directly above you, and there is 
only one of those.

> - Locking required to do updates: and remember our lock functions use
> methods in the array
>   

Yes, locking is an issue, but it is possible to do.  You just need to 
stop interrupts, NMIs, and faults on all processors simultaneously.  
Actually, it's not that scary - since you'll be doing it in a hypervisor.

> - If we boot patch inline code to get performance natively its almost
> impossible to then revert that.
>   

You can patch back over it.  I've already implemented the locking and 
repatching bits for VMI.

Zach

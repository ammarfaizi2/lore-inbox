Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVJOTOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVJOTOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJOTOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 15:14:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37598 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751200AbVJOTOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 15:14:55 -0400
Subject: Re: PATCH: EDAC atomic scrub operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4351530C.3070907@argo.co.il>
References: <1129402528.17923.9.camel@localhost.localdomain>
	 <4351530C.3070907@argo.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Oct 2005 20:44:02 +0100
Message-Id: <1129405443.17923.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-10-15 at 21:05 +0200, Avi Kivity wrote:
> >+static __inline__ void atomic_scrub(unsigned long *virt_addr, u32 size)
> >+{
> >+	u32 i;
> >+	for (i = 0; i < size / 4; i++, virt_addr++)
> >  
> >
> (size+7)  / 8? or increment virt_addr by 0.5? :)
> 
> >+		/* Very carefully read and write to memory atomically
> >+		 * so we are interrupt, DMA and SMP safe.
> >+		 */
> >+		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
> >  
> >
> shouldn't that be addq?


Should be u32 * for the address used. Well spotted. 

Alan


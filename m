Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVHYJi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVHYJi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVHYJi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:38:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:20390 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964907AbVHYJi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:38:57 -0400
Subject: Re: question on memory barrier
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Andy Isaacson <adi@hexapodia.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050825091403.6380.qmail@web25805.mail.ukl.yahoo.com>
References: <20050825091403.6380.qmail@web25805.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 11:07:20 +0100
Message-Id: <1124964440.21456.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-25 at 11:14 +0200, moreau francis wrote:
> I'm compiling Linux kernel for a MIPS32 cpu. On my platform, writel seems
> expand to:
> 
>     static inline writel(u32 val, volatile void __iomem *mem)
>     {
>             volatile u32 *__mem;
>             u32 __val;
> 
>             __mem = (void *)((unsigned long)(mem));
>             __val = val;
> 
>             *__mem = __val;
>     }
> 
> I don't see the magic in it since "volatile" keyword do not handle memory
> ordering constraints...Linus wrote on volatile keyword, see

For the case and the platform the volatile is sufficient to force
ordering. That or the arch code author made a mistake. But I think its
sufifcient for MIPS. The volatile prevents

	*foo = 1; 
	*foo = 2;

or even

	*foo;

from being collapsed together or eliminated


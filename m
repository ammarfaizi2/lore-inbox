Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129504AbRBEK6d>; Mon, 5 Feb 2001 05:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130633AbRBEK6Y>; Mon, 5 Feb 2001 05:58:24 -0500
Received: from colorfullife.com ([216.156.138.34]:19717 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129504AbRBEK6K>;
	Mon, 5 Feb 2001 05:58:10 -0500
Message-ID: <3A7E873E.54E3ECC2@colorfullife.com>
Date: Mon, 05 Feb 2001 11:58:06 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Stewart <T.Stewart@student.umist.ac.uk>
CC: Urban Widmark <urban@teststation.com>,
        Jonathan Morton <chromi@cyberspace.org>, linux-kernel@vger.kernel.org,
        ksa1 <ksa1@gmx.de>
Subject: Re: d-link dfe-530 tx (bug-report)
In-Reply-To: <3A7D77B5.ABF5A850@colorfullife.com> <3A7DEEB2.20915.276D09D@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Stewart wrote:
> 
> Right, i patched the via-diag and its showing more regs.
> 
> I applyed Manfred's patch but that changed nothing.
> Then I applyed your patch and still changed nothing as you suspected.
> But there are regs that are different.
> 
Several regs are just the wakeup frames, but some look suspicious.

Could you try Urban's patch, but add

<<<<<<<<
	writeb(0x00, ioaddr + 0x83);
	writel(0x01010000, ioaddr + 0xa0);
	writel(0x01010000, ioaddr + 0xa4)
	writew(0xffff, ioaddr + 0x72);
	writeb(0x08, ioaddr + 0x96);
>>>>>>>>>

just before
+      writeb(0x40, ioaddr + 0x81);    /* Force software reset */
(around line 540)

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

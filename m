Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbRBKUdM>; Sun, 11 Feb 2001 15:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130239AbRBKUdC>; Sun, 11 Feb 2001 15:33:02 -0500
Received: from colorfullife.com ([216.156.138.34]:20231 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130148AbRBKUc2>;
	Sun, 11 Feb 2001 15:32:28 -0500
Message-ID: <3A86F67D.53C1BD9B@colorfullife.com>
Date: Sun, 11 Feb 2001 21:30:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@fenrus.demon.nl>,
        Doug Ledford <dledford@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] framework for fpu usage in kernel
In-Reply-To: <E14S359-0004vi-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > memcopy is a really generic function, and calling it saves the current
> > fpu state into thread.i387.f{,x}save. IMHO that's wrong, memcopy must
> > save into a local buffer like raid5 checksumming.
> 
> The mmx copy is only done in task context. There are a whole variety
> of _horrible_ problems doing it in interrupt space so based on the
> considerable number of problems with prior attempts to get it right on
> IRQ and copyuser cases I didnt bother
>
Even task context is dangerous:

What if a drm module wants to use the fpu and then uses memcpy() after
modifying the ftp registers?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

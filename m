Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSAIXeh>; Wed, 9 Jan 2002 18:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSAIXeV>; Wed, 9 Jan 2002 18:34:21 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:37814 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S289088AbSAIXda>; Wed, 9 Jan 2002 18:33:30 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: "'Ville Herva'" <vherva@niksula.hut.fi>,
        "'Andrew Morton'" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>,
        "'Jani Forssell'" <jani.forssell@viasys.com>
Subject: RE: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Date: Wed, 9 Jan 2002 23:33:28 -0000
Message-ID: <001001c19966$0af99fd0$0100a8c0@icarus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <20020109235722.L1200@niksula.cs.hut.fi>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nice, yet one more variable to the equation ;). And I thought 
> I could rule out kernel bugs by reproducing this on 
> supposedly stable kernel (the 2.2.20 I used had all sort of 
> patches in it; ide, e2compr and raid to name the largest ones.)
> 
> This could be a sync_page_buffers() bug, but what puzzles me 
> is that I can reproduce the oopses on 2.2 as well (although 
> they can of course be different oopses). 
> 
> Also, I'm seeing ide and network corruption that would very 
> much point to pci transfer corruption. Of course, it can be 
> that the oopses are not caused by that.
[snip]

>From what I've read, it looks like there can be issues with the VIA
KT133 PCI implementation, possibly applying to other VIA chipsets too.

Master memory reads can talk 45 cycles rather than 16 (the max defined
in the PCI spec) - this sounds like it could be due to either a) bad
motherboard design with signal problems, or b) BIOS chipset
configuration (try setting 'PCI master read caching' to on?). This is
since problems have been reported with different make motherboards using
the same chipset, and those being the only two factors differing.

Of course, this may well not help if it is geniunely a bug in the
kernel, but may solve the PCI corruption (if any).

Also, if it is a chipset issue, updating the BIOS can help at times,
with the vendor incorporating work-arounds for known chipset problems
(eg the well-publicised IDE corruption issue).

Dan
___________________
Daniel J Blueman


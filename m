Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSEUXgB>; Tue, 21 May 2002 19:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSEUXf5>; Tue, 21 May 2002 19:35:57 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:525 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316792AbSEUXfQ>; Tue, 21 May 2002 19:35:16 -0400
Message-ID: <3CEAD9AF.9F6FD0FC@linux-m68k.org>
Date: Wed, 22 May 2002 01:35:11 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.33.0205211144180.3073-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

> If you care, the reason we need to do this on x86 is that the TLB walker
> is speculative and almost totally asynchronous wrt the rest of the CPU
> core, so we may have a CPU "TLB lookup thread" goin on in parallel with
> the TLB cleaning - and that TLB lookup may have looked up the pmd contents
> already but not resolved the entry yet. Which is why we have to
> synchronize the PMD freeing with the TLB flush - the same way we already
> have to do it for the regular data pages.

Alternative suggestion: remove the present bit from the pgd/pmd entry.
After you flushed the tlb, you can clean up the page tables without a
hurry. That will work on any sane system and you don't have to force
data and table pages into the same interface.

bye, Roman

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135618AbREDTOp>; Fri, 4 May 2001 15:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135759AbREDTO0>; Fri, 4 May 2001 15:14:26 -0400
Received: from colorfullife.com ([216.156.138.34]:33294 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S135618AbREDTOX>;
	Fri, 4 May 2001 15:14:23 -0400
Message-ID: <3AF2FF93.44A2C49@colorfullife.com>
Date: Fri, 04 May 2001 21:14:27 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-0.1.9smp i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: bergsoft@home.com, linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ---
> >       __asm__ __volatile__ (
> 158c157
> <               "3: movw $0x1AEB, 1b\n"
> ---
> >               "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
> 166c165
> < */
> ---
> >
> 170c169
> <               "1: nop\n" /* prefetch 320(%0)\n" */
> ---
> >               "1: prefetch 320(%0)\n"                                         
> -------------------------
>   Please let me know if that makes sense :).

Very interesting.
You've removed only the prefetch 320(%0), not the other prefetch
instructions?

prefetch 320(%0) can fetch memory behind the end of the source page.
Perhaps it accesses memory in the ISA hole, or beyond the end of memory?
Could you post the e820 map from dmesg?

It's possible to build manually a memory map.
Could you build one with wide margins from "dangerous" areas? (untested:
mem=exactmap mem=620k@0 mem=<your mem in MB-2>M@1M)

Then boot with prefetch enabled.
--
	Manfred

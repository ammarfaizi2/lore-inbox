Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132276AbRAIW61>; Tue, 9 Jan 2001 17:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAIW6H>; Tue, 9 Jan 2001 17:58:07 -0500
Received: from chiara.elte.hu ([157.181.150.200]:37900 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132293AbRAIW56>;
	Tue, 9 Jan 2001 17:57:58 -0500
Date: Tue, 9 Jan 2001 23:57:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Kaiser <rob@sysgo.de>
Cc: Brian Gerst <bgerst@didntduck.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01010923324500.02850@rob>
Message-ID: <Pine.LNX.4.30.0101092354140.9990-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Robert Kaiser wrote:

> Now comes the amazing (to me) part: I split the above statement up into:
>
> 	temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> 	*pte = temp;

this is almost impossible (except some really weird compiler bug) - unless
the mem_map address is invalid. This could happen if your kernel image is
*just* too large. Do things improve if you disable eg. ext2fs support (i
know, but should be enough to boot). Or if that part is not mapped
correctly (which does happen sometimes as well).

and are you sure it crashes there? [are you putting delays between your
printouts?]

> where temp is declared "volatile pte_t". I inserted test-prints between the
> above two lines. Accoding to that, the _first_ line , i.e. the evaluation of the
> mk_pte_phys() macro is causing the crash!

it accesses mem_map variable, which is near to the end of the kernel
image, so it could indeed something of that sort. An uncompressed kernel
image (including the data area) must not be bigger than 4MB (IIRC).

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

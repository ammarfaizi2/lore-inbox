Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136506AbREDVF7>; Fri, 4 May 2001 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136507AbREDVFt>; Fri, 4 May 2001 17:05:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46863 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136506AbREDVFg>; Fri, 4 May 2001 17:05:36 -0400
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
To: bergsoft@home.com (Seth Goldberg)
Date: Fri, 4 May 2001 22:09:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF2E569.47AED98D@home.com> from "Seth Goldberg" at May 04, 2001 10:22:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vmpN-000822-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the memory copy in the fast_page_copy routine.  The machine then
> proceeded
> not to stop at my panic, but I got my "normal" oopses.  I then had an

Ok

> idea and removed all the prefetch instructions from the beginning of the
> routine and tried the resultin kernel.  I now have no crashes.
> What could this mean?

I think it has to mean a hardware problem.

> Here is a nother patch just so you can keep me honest if I
> made another mistake:

There is a mistake but you wont trigger it. It is no longer 26 bytes 8)
That patch is only used when the prefetchw faults with an illegal instruction
and is done so you can boot an athlon kernel on a lesser cpu

The prefetch instructions hint to the CPU what memory we will access very soon.
The primary effect of that is that we hit full theoretical memory bandwidth
when copying pages. It doesnt really change execution behaviour in any other
way which then does rather point to cpu or other hardware problem. The very
early athlons had prefetch bugs but we would not trigger those and no reporters
have such an early CPU.

What still stands out is that exactly _zero_ people have reported the same
problem with non VIA chipset Athlons.


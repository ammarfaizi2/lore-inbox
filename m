Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQKHAuf>; Tue, 7 Nov 2000 19:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQKHAuZ>; Tue, 7 Nov 2000 19:50:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27416 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129765AbQKHAuO>; Tue, 7 Nov 2000 19:50:14 -0500
Subject: Re: Installing kernel 2.4
To: jmerkey@timpanogas.org (Jeff V. Merkey)
Date: Wed, 8 Nov 2000 00:49:33 +0000 (GMT)
Cc: kernel@kvack.org, gandalf@wlug.westbo.se (Martin Josefsson),
        tigran@veritas.com (Tigran Aivazian), anils_r@yahoo.com (Anil kumar),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A088C02.4528F66B@timpanogas.org> from "Jeff V. Merkey" at Nov 07, 2000 04:10:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tJQl-0007zp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are tests for all this in the feature flags for intel and
> non-intel CPUs like AMD -- including MTRR settings.  All of this could
> be dynamic.  Here's some code that does this, and it's similiar to
> NetWare.  It detexts CPU type, feature flags, special instructions,
> etc.  All of this on x86 could be dynamically detected.   

Detection isnt the issue, its optimisations. Our 386 kernel build is the
detect all run on any one.

>     mov      sp, bx
>     mov      CPU_TYPE, 3  ; 80386 detected
>     jz       end_get_cpuid

This is wrong btw. You don;t check for Cyrix with CPUID disabled or
the NexGen or pre CPUID Cyrix...

> check_CMPXCHG8B:
>     mov      ax, word ptr ds:FEATURE_FLAGS
>     and      ax, CMPXCHG8B_FLAG
>     jz       check_4MB_paging

This needs a few other bits of interesting checking for non intel chips

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

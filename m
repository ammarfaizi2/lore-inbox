Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRAWSXh>; Tue, 23 Jan 2001 13:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRAWSX2>; Tue, 23 Jan 2001 13:23:28 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:60388 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129655AbRAWSXP>; Tue, 23 Jan 2001 13:23:15 -0500
Date: Tue, 23 Jan 2001 19:12:36 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Mark Mokryn <mark@sangate.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <3A6D5D28.C132D416@sangate.com>
Message-ID: <Pine.GSO.4.10.10101231903380.14027-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jan 2001, Mark Mokryn wrote:

> ioremap_nocache does the following:
> 	return __ioremap(offset, size, _PAGE_PCD);
> 
> However, in drivers/char/mem.c (2.4.0), we see the following:
> 
> 	/* On PPro and successors, PCD alone doesn't always mean 
> 	    uncached because of interactions with the MTRRs. PCD | PWT
> 	    means definitely uncached. */ 
> 	if (boot_cpu_data.x86 > 3)
> 		prot |= _PAGE_PCD | _PAGE_PWT;
> 
> Does this mean ioremap_nocache() may not do the job?

ioremap creates a new mapping that shouldn't interfere with MTRR, whereas
you can map a MTRR mapped area into userspace. But I'm not sure if it's
correct that no flag is set for boot_cpu_data.x86 <= 3...

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

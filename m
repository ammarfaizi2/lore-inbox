Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAWKcG>; Tue, 23 Jan 2001 05:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129757AbRAWKbq>; Tue, 23 Jan 2001 05:31:46 -0500
Received: from c017-h014.c017.sfo.cp.net ([209.228.12.228]:16330 "HELO
	c017.sfo.cp.net") by vger.kernel.org with SMTP id <S129737AbRAWKbg>;
	Tue, 23 Jan 2001 05:31:36 -0500
X-Sent: 23 Jan 2001 10:31:29 GMT
Message-ID: <3A6D5D28.C132D416@sangate.com>
Date: Tue, 23 Jan 2001 12:30:00 +0200
From: Mark Mokryn <mark@sangate.com>
Organization: SANgate Systems
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: ioremap_nocache problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap_nocache does the following:
	return __ioremap(offset, size, _PAGE_PCD);

However, in drivers/char/mem.c (2.4.0), we see the following:

	/* On PPro and successors, PCD alone doesn't always mean 
	    uncached because of interactions with the MTRRs. PCD | PWT
	    means definitely uncached. */ 
	if (boot_cpu_data.x86 > 3)
		prot |= _PAGE_PCD | _PAGE_PWT;

Does this mean ioremap_nocache() may not do the job?

-mark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

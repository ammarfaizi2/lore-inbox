Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264395AbTKUSMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 13:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTKUSMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 13:12:49 -0500
Received: from relay-3m.club-internet.fr ([194.158.104.42]:7573 "EHLO
	relay-3m.club-internet.fr") by vger.kernel.org with ESMTP
	id S264395AbTKUSMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 13:12:47 -0500
From: pinotj@club-internet.fr
To: akpm@osdl.org, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Fri, 21 Nov 2003 19:12:43 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069438363.27768.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Message d'origine----
>Date: Wed, 19 Nov 2003 18:09:43 -0800
>De: Andrew Morton <akpm@osdl.org>
>A: pinotj@club-internet.fr
>Copie à: linux-kernel@vger.kernel.org
>Sujet: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
[...]
>Well it's interesting that it is repeatable.
>
>First thing to do is to eliminate hardware failures:
>
>1: Is the oops always the same, or does the machine crash in other ways,
>   with different backtraces?
>
>2: Try running memtest86 on that machine for 12 hours or more.
>
>3: Can the problem be reproduced on other machines?
>
>4: try a different compiler version.

First, some results about some tests (not finish yet)

0. Increase verbosity of the printk (thanks to Manfred):
(compilation of kernel)
slab: double free detected in cache 'buffer_head', objp c4c8e3d8, objnr 10,
slabp c4c8e000, s_mem c4c8e180, bufctl ffffffff.
(compilation of firebird)
slab: double free detected in cache 'pte_chain', objp c18a6600, objnr 10,
slabp c18a6000, s_mem c18a6100, bufctl ffffffff.

1. Reproductibility : yes, it oops each time I try to compile a kernel, for example, at around 75% of the task.
Always oops if I try to compile during a quite long time
One funny thing, though. I got one oops without freeze. After error of gcc, I went back to the shell but when I called ksymoops 2 commands later, everything freezed.
About the backtrace, well I'm not sure. Are you talking about what follow the `call trace` etc ? The problem is the system don't have always the time to flush everything to the log, I often got only the printk. But I always got the cache_flusharray thing in first position.

2. Test mem (not yet, I need some time). But as I said, I never had oops before, with 2.6.0-test from 4 to 9. I compiled all my LFS with 2.6.0-test9 vanilla without problem.
3. Change compiler: confirm same problem with gcc 2.95.3, 3.2.3, 3.3.1
x. ACPI: same oops with `acpi=off pci=noacpi` at boot

Summary: Oops reproductible when heavy load, bug in mm/slab.c
Don't have this problem with 2.6.0-test9 and prior
Problem appears in the last patches, before 15 november
(cset-20031115_0206) so I looked for something wrong.

I tried to remove some of the last patches (mm/ioremap.c, 
mm/filemap.c, mm/memory.c) but still got oops.
Should be another patch. Which one else can I remove to test ?

Regards,

Jerome


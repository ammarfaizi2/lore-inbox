Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129658AbQKOMhO>; Wed, 15 Nov 2000 07:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129801AbQKOMhF>; Wed, 15 Nov 2000 07:37:05 -0500
Received: from capitanata.ca.astro.it ([192.167.8.254]:56335 "EHLO
	capitanata.ca.astro.it") by vger.kernel.org with ESMTP
	id <S129658AbQKOMg7>; Wed, 15 Nov 2000 07:36:59 -0500
Date: Wed, 15 Nov 2000 13:06:51 +0100 (CET)
From: Giacomo Mulas <gmulas@ca.astro.it>
To: linux-kernel@vger.kernel.org
cc: gmulas@ca.astro.it
Subject: Processor-dependent bug in kernel 2.4.0-testX (floating point
 exception)
Message-ID: <Pine.LNX.4.21.0011151233240.6114-100000@capitanata.ca.astro.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I stumbled upon a strange bug in the 2.4.0-test[9-10] kernels,
which only happens on PII (Deschutes) processors: right after boot, it
starts spitting "floating point exception"s all over the place, every time
aborting the program it was executing. This begins to happen very early,
before any modules have been loaded. I do not know whether this bug was
present in previous 2.4.0-test versions.
	Notably, the kernels are recompiled with the same source and
options of the one that is currently running without problems on my laptop
and on all other PIIIs I tried it on, except for the processor option,
which is set to "Pentium III" for PIIIs and to
"Pentium-Pro/Celeron/Pentium II" for PIIs. I just did:

cp .config .config.myconfig
make mrproper
mv .config.myconfig .config
make menuconfig
<change only processor family and save>
make dep
make bzImage
make modules
<install, adjust lilo and reboot>
floating point exceptions when fscking partitions, when doing depmod...
No oopses.

This happens exactly in the same way on two different computers with the
same hardware configuration, so I don't think it is a hardware bug, and
both work fine with a 2.2.17 kernel. The floating point exceptions are not
deterministic, they do not always happen at the same point in the boot
process, but are random and frequent. Any program that runs for a long
enough time (e.g. a tripwire run) invariably triggers it.

Please ask any more needed information and I will gladly provide it.

Bye
Giacomo Mulas

________________________________________________________________________

Giacomo Mulas <gmulas@ca.astro.it, gmulas@tiscalinet.it, gmulas@eso.org>
________________________________________________________________________

OSSERVATORIO  ASTRONOMICO                                                
Str. 54, Loc. Poggio dei Pini * 09012 Capoterra (CA)

Tel.: +39 070 71180 216     Fax : +39 070 71180 222
________________________________________________________________________

"When the storms are raging around you, stay right where you are"
                         (Freddy Mercury)
________________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

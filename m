Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbQKPOn7>; Thu, 16 Nov 2000 09:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbQKPOnu>; Thu, 16 Nov 2000 09:43:50 -0500
Received: from ns.caldera.de ([212.34.180.1]:56586 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129416AbQKPOnb>;
	Thu, 16 Nov 2000 09:43:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14867.60258.282676.883552@ns.caldera.de>
Date: Thu, 16 Nov 2000 15:12:50 +0100 (CET)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <E13wHVO-0007VB-00@the-village.bc.nu>
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de>
	<E13wHVO-0007VB-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
From: Torsten Duwe <duwe@caldera.de>
Reply-to: Torsten.Duwe@caldera.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    >> >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
    >> 
    Francis> Just in case... Some modules have uppercase letters too :)
    >> That's what the &0xdf is intended for...

Jah, Bummer from my side; use "|0x20" instead. But as discussed, isalnum()
does the perfect job, for readability and efficiency.

    Alan> That looks wrong for UTF8 which is technically what the kernel uses
    Alan> 8)

Hmm, haf-a-amiley. Are module names to be localized or are they considered
"international code" like the sources, limiting them to 7-Bit ASCII.

What's your opinion, Alan ? Linus ?

I'd consider it "system internal", not visible to the user and hence 7-Bit
must suffice. I also strongly agree with Keith: treating strings that come
from the kernel as tainted is weird at least.

I suggest to stick with [A-Za-z0-9_-]*, adding a check for the first char not
being '-', maybe modifying devfs do use dashes ("dev-") and auditing the rest
of the kernel BTW. The M$-FSes look a little suspicious to me with their
"nls_*" stuff. CAP_SYS_MOUNT (once established) might then be turned into
CAP_SYS_MODULE this way (mount -t vfat -o conv="; chmod ...") ???

Keith: what about the good-ole' "--" to specify end-of-options ? Every word
after that could be treated as a simple module name.

	Torsten

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

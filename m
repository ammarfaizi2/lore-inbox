Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRAQSTB>; Wed, 17 Jan 2001 13:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRAQSSv>; Wed, 17 Jan 2001 13:18:51 -0500
Received: from gwfs.stud.fh-jena.de ([194.94.37.56]:37900 "EHLO
	gwfs.stud.fh-jena.de") by vger.kernel.org with ESMTP
	id <S132660AbRAQSSm>; Wed, 17 Jan 2001 13:18:42 -0500
From: Michael Palme <962etmp@gwfs.stud.fh-jena.de>
Message-Id: <200101171818.TAA17262@gw4s.stud>
Subject: krnl newbie: problems with EXPORT_SYMBOL()
To: linux-kernel@vger.kernel.org
Date: Wed, 17 Jan 2001 19:18:40 +0100 (MET)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello...

ive got a problem with the EXPORT_SYMBOL() macro. i have 2 modules. one of
them uses functions which the other module exports . everything works fine
as long as i leave the symbols global which i want to export in the
exporting module. i want to use EXPORT_SYMBOL() for this task, so that i
can use global symbols without them beeing exported to the kernel symbol
table (i cant use static declaration cause i need some global vars). now
when i try to use it this way (compile is a success) the other module cant
find the external references anymore. EXPORT_SYMBOL_NOVERS() works.

-----can be ignored ------
i think it has something to do with the version information on symbols . i
havent declared MODVERSIONS or included linux/modversions.h. if i use
"nm" on the module object file i get the right name for the symbols like:
000000  D symbol_exported
but after insmoding it and trying "ksyms" it is reported as:
d801e0dc  symbol_exported_R__symbol_exported
when i use global symbols or EXPORT_SYMBOLS_NOVERS() it is normal:
d801e0dc  symol_exported
i think this _R_xxx could be the reason that the other module cant find
the symbol ??? But i also read insmod manpage and they said if modules are
compiled without versioning the CRC information on symbols will be ignored
??? ok it is no real CRC info in this case but i think the whole string
after_R will be ignored ??? i also read linux/modules.h and i wondered
about the way EXPORT_SYMBOLS is handled if no versioning is used. for this
case i would have expected that its behaviour is like
EXPORT_SYMBOLS_NOVERS.
-------------------------
i really want to get EXPORT_SYMBOLS working.
Could somebody help me please!!!!!!!!

Thanks in advance...Michael Palme

im sorry when suggestions are wrong but i havent much knowledge off the
internals.

P.S.: I ran kernel 2.2.14, 2.2.16, 2.2.18, 2.4.0 (i tried kernels with and
without version information on modules) and tested modutils 2.3.19 and
2.4.1; gcc is 2.95.2 machine x86

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

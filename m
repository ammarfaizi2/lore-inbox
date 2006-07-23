Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWGWRzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWGWRzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWGWRzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 13:55:25 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:122 "EHLO rudy.mif.pg.gda.pl")
	by vger.kernel.org with ESMTP id S1751264AbWGWRzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 13:55:24 -0400
Date: Sun, 23 Jul 2006 19:55:16 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
In-Reply-To: <20060723112005.GA6815@martell.zuzino.mipt.ru>
Message-ID: <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl>
References: <44C099D2.5030300@s5r6.in-berlin.de>
 <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
 <1153478157.9489.30.camel@hemera> <Pine.LNX.4.58.0607211336450.26827@sbz-30.cs.Helsinki.FI>
 <44C0B29F.2080604@s5r6.in-berlin.de> <Pine.BSO.4.63.0607221949490.10018@rudy.mif.pg.gda.pl>
 <44C26D90.4030307@s5r6.in-berlin.de> <Pine.BSO.4.63.0607222030370.10018@rudy.mif.pg.gda.pl>
 <44C28472.2080509@pobox.com> <Pine.BSO.4.63.0607222242100.10018@rudy.mif.pg.gda.pl>
 <20060723112005.GA6815@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1604466841-1153677316=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1604466841-1153677316=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 23 Jul 2006, Alexey Dobriyan wrote:
[..]
>> Again: using indent mainly will mean only one time massive changes.
>
> True, 180M(!) of them.

~160M.
And this is so huge now because seems there is no obligation use common 
format .. all is formated using hands/mind/difftent editors autoformaters.

>> After
>> this ident can be runed for example by Linus just before make release
>> and/or partial release.
>
> ~4M per run.

If patch submmitter will use formating tool and it will add it will statr 
work on formated source tree it will be 0M per run.

>>> scripts/Lindent exists and gets used, but it is not perfect.
>
> Correction: GNU indent exists and gets used, but it is not perfect.

Yes .. and produce by Lindent ~160MB patch it excelent proof how offent is 
is used now :>
(please stop this crap "argumentation" :>)

> Last time I checked BSD indent don't have some option Lindent use.
> forgot which.

Any problems with use BDS indent instead GNU ?

>> Again: anywhere are listed/was posted list of "not perfect" examples ?
>
> OOhhhh, please do
>
> 	find . -type f -name '*.[ch]' | xargs ./scripts/Lindent
>
> on any large C codebase.

Runing above on linux-2.6.17.6 tree produces 248 errors mainly because was 
used *bad coding style*. I.e. by keep in distribution tree some strange 
pieces of code like:

#if 0
 	if () {
#endif
 	if () {

 	}

>> And/or: what does it mean in this case "not perfect" ?
>
>> Show this  for
>> allow start work on fix indent by other people (if all cases will be resul
>> of some bugs in this tool).
>
> Start fixing indent(1) if you're serious about all this. There are
> _plenty_ of C code flying around.

IMO .. first will be good xcleanup some Linux code by remove some to many 
multiple using C preprocessor stantments which seems is now main cause 
why indent can be used.
Current linux-2.6.17.6 tree have 16028 *.[ch] files.
Gnu indet produces errors on:

[linux-2.6.17.6]$ find -name \*.c -o -name \*.h | xargs indent -npro -kr \
 	-i8 -ts8 -sob -l80 -ss -ncs 2>&1 | awk '{print $2}' | awk -F: \
 	'{print $1}' | sort | uniq | wc -l
76

*76 files*

Again: using indent requires keep code in some order. General "Coding 
Style" is list of rules. It will be now add one new simple rule "keep code 
in form which allow use indent without producing errors".

Below list of files on which now indent produces orrors (from 2.6.17.6 
tree):

./arch/xtensa/mm/tlb.c
./drivers/atm/iphase.c
./drivers/cdrom/cm206.c
./drivers/cdrom/mcdx.c
./drivers/char/ftape/lowlevel/ftape-bsm.c
./drivers/char/ip2/ip2main.c
./drivers/char/serial167.c
./drivers/i2c/algos/i2c-algo-bit.c
./drivers/ide/legacy/hd.c
./drivers/ide/pci/alim15x3.c
./drivers/isdn/hardware/eicon/capifunc.c
./drivers/isdn/hisax/l3dss1.c
./drivers/md/linear.c
./drivers/media/video/w9968cf.c
./drivers/net/cris/eth_v10.c
./drivers/net/eepro100.c
./drivers/net/sk98lin/skdim.c
./drivers/net/sk98lin/skge.c
./drivers/net/sk98lin/skgesirq.c
./drivers/net/wireless/i82586.h
./drivers/net/yellowfin.c
./drivers/parport/parport_arc.c
./drivers/s390/cio/qdio.c
./drivers/s390/s390mach.c
./drivers/sbus/char/aurora.c
./drivers/scsi/3w-9xxx.c
./drivers/scsi/53c7xx.c
./drivers/scsi/lpfc/lpfc_init.c
./drivers/scsi/seagate.c
./drivers/scsi/st.c
./drivers/serial/68328serial.c
./drivers/serial/crisv10.c
./drivers/usb/host/hc_crisv10.c
./drivers/usb/input/hid-core.c
./drivers/video/intelfb/intelfbhw.c
./drivers/video/neofb.c
./drivers/video/sis/init301.c
./fs/jffs2/wbuf.c
./fs/jffs/intrep.c
./fs/jfs/jfs_txnmgr.c
./fs/ntfs/super.c
./include/asm-frv/math-emu.h
./include/asm-m68k/atariints.h
./include/asm-m68k/math-emu.h
./include/asm-m68k/raw_io.h
./include/asm-m68k/tlbflush.h
./include/asm-mips/delay.h
./include/asm-s390/page.h
./include/asm-x86_64/calling.h
./include/asm-xtensa/xtensa/coreasm.h
./sound/isa/es18xx.c
./sound/oss/ad1889.c
./sound/oss/cs4232.c
./sound/oss/sb_ess.c

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1604466841-1153677316=:10018--

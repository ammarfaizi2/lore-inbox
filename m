Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSLAVPc>; Sun, 1 Dec 2002 16:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSLAVPb>; Sun, 1 Dec 2002 16:15:31 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S262469AbSLAVPb>; Sun, 1 Dec 2002 16:15:31 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <mzyngier@freesurf.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [2.4.20] alpha (alcor) failing during boot: NCR53c810/NCR53c875 give error "Cache test failed"
Date: Sun, 1 Dec 2002 22:22:55 +0100
Message-ID: <003601c2997f$d0dac610$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <wrplm39scb7.fsf@hina.wild-wind.fr.eu.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FvH> My Dec Alpha (Alcor) runs fine with 2.2.20.
FvH> With 2.4.20, it fails during boot at the init. of the scsi-devices.
FvH> Error is:
M> [...]
M> Please give 2.4.20-ac1 a try. It includes the CIA-1 fix that prevent
M> Alcor machines (AS500 and co) from working.

That one introduces a new problem:

gcc -D__KERNEL__ -I/data/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pi
pe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6   -nostdinc -iwithprefix
include -DKBUILD_BASENAME=compat  -c -o compat.o compat.c
make[3]: *** No rule to make target
`/data/src/linux-2.4.20/drivers/pci/devlist.h', needed by `names.o'.  Stop.

In .depend I had to delete the reference to devlist.h and classlist.h.
Dirty, but it made the compilation go on.


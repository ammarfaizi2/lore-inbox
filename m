Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDFUVX>; Fri, 6 Apr 2001 16:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRDFUVN>; Fri, 6 Apr 2001 16:21:13 -0400
Received: from front7m.grolier.fr ([195.36.216.57]:9709 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132398AbRDFUVG> convert rfc822-to-8bit; Fri, 6 Apr 2001 16:21:06 -0400
Date: Fri, 6 Apr 2001 19:09:43 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.LNX.4.05.10104052136070.509-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10104061858200.8443-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Apr 2001, Geert Uytterhoeven wrote:

> 
> BTW, my 2.4.3-pre8 kernel just said
> 
> | sym53c875-0:0: ERROR (81:0) (3-21-0) (10/9d) @ (script 8a8:0b000000).

Illegal instruction detected.

> | sym53c875-0: script cmd = 11000000
> | sym53c875-0: regdump: da 10 80 9d 47 10 00 0d 00 03 80 21 80 01 09 09 00 30 4e 00 08 ff ff ff.
> | sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 16)
> 
> during the boot process, and continued without problems. What does this mean?

Looks extremally serious to me.

The SCRIPTS processor should be fetching CHMOV DSA relative when DATA_IN
instructions. This corresponds to opcode 0x11000000.

However, it seems to have fetched instruction 0x0b000000 which is a 
MOVE ABSOLUTE WHEN STATUS PHASE.

In (3-21-0) we can see that the chip is expecting STATUS PHASE (3), but
the target is driving DATA IN phase (21 - the 1 indicates DATA IN phase).

In other word, the SCRIPTS processor seems to have fetched a bogus
instruction. The signaled 'illegal instruction detected' may be due to the 
count of bytes to transfer to be zero.

> Gr{oetje,eeting}s,

  Gérard.


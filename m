Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUFFUHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUFFUHy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUFFUHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:07:54 -0400
Received: from spoolo1.tiscali.be ([62.235.13.172]:62673 "EHLO
	spoolo1.tiscali.be") by vger.kernel.org with ESMTP id S264108AbUFFUGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:06:03 -0400
Message-ID: <40C3799B.6000105@tiscali.be>
Date: Sun, 06 Jun 2004 20:07:55 +0000
From: Joel Soete <soete.joel@tiscali.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040528 Debian/1.6-7
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [parisc-linux] linux and gcc 3.x question?]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-------- Original Message --------
Subject: [parisc-linux] linux and gcc 3.x question?
Date: Thu, 3 Jun 2004 17:17:01 +0200
From: Joel Soete <soete.joel@tiscali.be>
To: parisc-linux@parisc-linux.org

Hello all,

I just noticed this harmless detail when I pre-compile some ncr53c8xx.c with gcc-3.3.4 on
my parisc-linux box as follow:
"gcc -Wp,-MD,drivers/scsi/.zalon53c720.o.d -nostdinc -iwithprefix include
-D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -pipe -mno-space-regs -mfast-indirect-calls -mdisable-fpregs
-ffunction-sections -O2
-DCONFIG_NCR53C8XX_PREFETCH -DSCSI_NCR_BIG_ENDIAN -DCONFIG_SCSI_NCR53C8XX_NO_WORD_TRANSFERS
   -DKBUILD_BASENAME=ncr53c8xx -DKBUILD_MODNAME=zalon7xx -E -o drivers/scsi/ncr53c8xx.o
drivers/scsi/ncr53c8xx.c"

I got (in drivers/scsi/ncr53c8xx.o):
[...]
static __inline__ __attribute__((always_inline)) __attribute__((always_inline))
int __attribute__((deprecated)) check_region(unsigned long s, unsigned long
n)
[...]

(2 time __attribute__((always_inline))?)
It comes from:

include/linux/compiler-gcc3.h
[...]

#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
# define inline         __inline__ __attribute__((always_inline))
# define __inline__     __inline__ __attribute__((always_inline))
# define __inline       __inline__ __attribute__((always_inline))
#endif
[...]

because when I comment the second "define", I got better:
[...]
static __inline__ __attribute__((always_inline)) int __attribute__((deprecated))
check_region(unsigned long s, unsigned long n)
[...]

I very doubt that's the right thing to do so if somebody as any idea?


TIA,
     Joel

PS: please make me in cc (I am not in this list)


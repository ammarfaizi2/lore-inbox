Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293484AbSCABMX>; Thu, 28 Feb 2002 20:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310237AbSCABJA>; Thu, 28 Feb 2002 20:09:00 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:53495 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S310279AbSCABGx>; Thu, 28 Feb 2002 20:06:53 -0500
Message-ID: <3C7ED47B.4000104@oracle.com>
Date: Fri, 01 Mar 2002 02:08:11 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.6-pre2: ide.c doesn't build if no IDE chipsets chosen
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.6-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=ide  -DEXPORT_SYMTAB -c ide.c
ide.c:161: parse error before "ide_pio_timings"
ide.c:161: warning: type defaults to `int' in declaration of `ide_pio_timings'
ide.c:162: warning: braces around scalar initializer
ide.c:162: warning: (near initialization for `ide_pio_timings[0]')
ide.c:162: warning: excess elements in scalar initializer
ide.c:162: warning: (near initialization for `ide_pio_timings[0]')
ide.c:162: warning: excess elements in scalar initializer
ide.c:162: warning: (near initialization for `ide_pio_timings[0]')
ide.c:163: warning: braces around scalar initializer
ide.c:163: warning: (near initialization for `ide_pio_timings[1]')
ide.c:163: warning: excess elements in scalar initializer
ide.c:163: warning: (near initialization for `ide_pio_timings[1]')

etc. etc.

Turns out ide_pio_timings_t is only defined within a
  #ifdef CONFIG_BLK_DEV_IDE_MODES block. That one seems to only kick
  in if I select at least one if the IDE chipsets. Mine is a PIIX4,
  but the configuration help seems to suggest I only set it if I
  suspect BIOS problems so I can hand-tune the chipset via hdparm;
  "if unsure, say N". I've been doing so for more time than I can
  remember without any issue and a spiffy hdparm output - this is
  the current 2.4.19-pre1 from which I built 2.5.6-pre2:

[root@dolphin root]# hdparm -tT /dev/hda

/dev/hda:
  Timing buffer-cache reads:   128 MB in  0.80 seconds =160.00 MB/sec
  Timing buffered disk reads:  64 MB in  3.99 seconds = 16.04 MB/sec


I now built the kernel after selecting PIIXn support, but is this
  a bug in the dependencies or in the configuration help text for
  the PIIXn chipsets ?


Thanks,

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")


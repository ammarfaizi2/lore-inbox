Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317908AbSFNMcB>; Fri, 14 Jun 2002 08:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317909AbSFNMcB>; Fri, 14 Jun 2002 08:32:01 -0400
Received: from bs1.dnx.de ([213.252.143.130]:54704 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S317908AbSFNMb7>;
	Fri, 14 Jun 2002 08:31:59 -0400
Date: Fri, 14 Jun 2002 14:31:40 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linux-kernel@vger.kernel.org
Subject: Accessing odd bytes
Message-ID: <20020614143140.A7467@schwebel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange effect on an embedded system (AMD Elan SC410,
Linux-2.4.18) while accessing a static RAM.  The RAM is mapped to the bus
at 0x0200'0000. If I map it to user space this way: 

  pSRAM  = (unsigned short *)mmap(0, 0x00040000, PROT_READ + PROT_WRITE, MAP_SHARED, FD, 0x2000000);

and fill it like this: 

  pByte=(char*)pSRAM;
  for (i=0; i<10; i++) {
    *pByte++=(char)i;
  }

  pByte=(char*)pSRAM;
  for (i=0; i<10; i++) {
    printf("i: %02i -> %03i\n", i, *pByte++);
  }

I see a mirroring effect: 

  i: 00 -> 001
  i: 01 -> 001
  i: 02 -> 003
  i: 03 -> 003
  i: 04 -> 005
  i: 05 -> 005
  i: 06 -> 007
  i: 07 -> 007
  i: 08 -> 009
  i: 09 -> 009

Now I'm wondering how the kernel/processor handles odd byte access
exceptions. Can anybody give me a pointer where I could search or what my
problem could be? 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

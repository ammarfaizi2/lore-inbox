Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136661AbRAHDiV>; Sun, 7 Jan 2001 22:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136665AbRAHDiK>; Sun, 7 Jan 2001 22:38:10 -0500
Received: from nlakdiva.slt.lk ([203.115.0.1]:24462 "EHLO lakdiva.slt.lk")
	by vger.kernel.org with ESMTP id <S136661AbRAHDiA>;
	Sun, 7 Jan 2001 22:38:00 -0500
Message-ID: <3A59DE82.2A175A3@sri.receiptcity.com>
Date: Mon, 08 Jan 2001 09:36:34 -0600
From: dhammika <dpathirana@sri.receiptcity.com>
Organization: mobinetix systems
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: understanding gunzip
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i tried 2.4.0 kernel with rmk and np patches in my brutus board. (Brutus
is a StrongArm based development environment)

my patched kernel is 2.4.0-rmk1-np1

the kernel uncompresses fine. but uncompressing the ramdisk fails. In
this  instance my uncompressed ramdisk is about 3.5mb.

i looked in to gunzip() routine. in inflate() (inflate.c)
i found following,

  do {
    hufts = 0;
    gzip_mark(&ptr);
    if ((r = inflate_block(&e)) != 0) {
      gzip_release(&ptr);
      return r;
    }
    gzip_release(&ptr);
    if (hufts > h)
      h = hufts;
  } while (!e);

and gzip_mark() and gzip_release() are defined in rd.c as,

static void __init gzip_mark(void **ptr)
{
}

static void __init gzip_release(void **ptr)
{
}

now if i comment these gzip_mark and gzip_release lines then the kernel
would complain,

Out of memory

 -- System halted

then i tried to see where ptr is poinitng to, according to the
System.map it points to a variable called insize,

it's defined as

./arch/arm/boot/compressed/misc.c     :     static unsigned insize = 0;
/* valid bytes in inbuf */

i don't understand what is happening here!! or did i miss anything??

tia

dhammika




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

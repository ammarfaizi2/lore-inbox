Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRDIKCG>; Mon, 9 Apr 2001 06:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132713AbRDIKB4>; Mon, 9 Apr 2001 06:01:56 -0400
Received: from mail.isl.tm.fr ([195.115.170.34]:10001 "EHLO mercure.isl.tm.fr")
	by vger.kernel.org with ESMTP id <S132708AbRDIKBp>;
	Mon, 9 Apr 2001 06:01:45 -0400
Message-ID: <3AD187B8.6BD5F7E9@isl.tm.fr>
Date: Mon, 09 Apr 2001 11:58:16 +0200
From: "Armin L. Schneider" <schneider@isl.tm.fr>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: module doesn't work when it's app uses STDOUT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry, this might be a beginner question, but I couldn't find any
infos in the FAQ.

I'm writing a driver (module) for a PCI card with a neural processor
(NP-processor) on it for kernel 2.4.1. The registers of this processor
are mapped to a memory area. I access the different registers of the
NP-processor with ioctl's (there are 8bit and 16bit registers):

    switch (cmd) {
      case NP_IOCSGCR:
          get_user (b, (byte *) arg);
          writeb (b, np.mem + Z_GCR);
          break;
      case NP_IOCGGCR:
          b = readb (np.mem + Z_GCR);
          put_user (b, (byte *) arg);
          break;
      case NP_IOCSMIF:
          get_user (w, (word *) arg);
          writew (w, np.mem + Z_MIF);
          break;
      case NP_IOCGMIF:
          w = readw (np.mem + Z_MIF);
          put_user (w, (word *) arg);
          break;

When I load the module and init the device, I can read the registers.
Some of them have default values after a reset of the chip and they
are ok. But when I load data to the registers and let the NP-processor
categorize the data, strange things happen:

I wrote a program to test the driver which loads some data to the
NP-processor and tries to categorize it. The program prints its
result to STDOUT.
  - everything works ok, results are correct, if I redirect STDOUT to a
     file
  - if I don't redirect, I get reproducibly wrong results when I print
     to STDOUT

My first idea was to disable/enable  interrupts when entering/leaving
the ioctl-function (using save_flags(); cli(); and restore_flags();),
but it
didn't help.

Armin.




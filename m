Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSEUKK1>; Tue, 21 May 2002 06:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSEUKK0>; Tue, 21 May 2002 06:10:26 -0400
Received: from unet4-131.univie.ac.at ([131.130.233.131]:1152 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S312498AbSEUKKZ>;
	Tue, 21 May 2002 06:10:25 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.17: compile error: sound/driver/opl3/opl3_oss.c 
Date: Tue, 21 May 2002 12:05:08 +0200
User-Agent: KMail/1.4.5
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200205211205.09824@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is now the third or fourth kernel in a row that exhibits the same
compile error. The configuration is as follows:

  CONFIG_SOUND=m
  CONFIG_SND=m
  CONFIG_SND_SEQUENCER=m                      <====  [1]
  # CONFIG_SND_OSSEMUL is not set
  # CONFIG_SND_RTCTIMER is not set
  CONFIG_SND_VERBOSE_PRINTK=y
  CONFIG_SND_DEBUG=y
  CONFIG_SND_DEBUG_MEMORY=y
  CONFIG_SND_DEBUG_DETECT=y
  CONFIG_SND_MPU401=m
  CONFIG_SND_CS4232=m
  CONFIG_SND_CS4236=m
  CONFIG_SND_OPL3SA2=m


And that's what I get during "make modules":

  gcc -D__KERNEL__ -I/usr/src/linux-2.5.17/include -Wall -Wstrict-prototypes \
    -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common \
    -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE \
    -DKBUILD_BASENAME=opl3_oss -c -o opl3_oss.o opl3_oss.c
  opl3_oss.c:25: parse error before `*'
  opl3_oss.c:25: warning: function declaration isn't a prototype
  opl3_oss.c:26: parse error before `*'
  opl3_oss.c:26: warning: function declaration isn't a prototype
  opl3_oss.c:27: parse error before `*'
  opl3_oss.c:27: warning: function declaration isn't a prototype
  opl3_oss.c:28: parse error before `*'
  opl3_oss.c:28: warning: function declaration isn't a prototype
  opl3_oss.c:29: parse error before `*'
  opl3_oss.c:29: warning: function declaration isn't a prototype
  opl3_oss.c:49: parse error before `oss_callback'
  opl3_oss.c:49: warning: type defaults to `int' in declaration of `oss_callback'
  opl3_oss.c:50: unknown field `owner' specified in initializer
  opl3_oss.c:50: warning: initialization makes integer from pointer without a cast
  opl3_oss.c:51: unknown field `open' specified in initializer
  opl3_oss.c:51: warning: excess elements in scalar initializer
  [lots of further similar errors]


Seems that there are some header definitions missing, such as
sound/core/seq/oss/seq_oss_device.h and others.

[1]  The kernel compiles if I unset CONFIG_SND_SEQUENCER.

m.


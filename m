Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTE1Fa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTE1Fa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:30:56 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:30482 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264531AbTE1Faz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:30:55 -0400
Date: Wed, 28 May 2003 07:46:41 +0200
From: Jerome Chantelauze <jerome.chantelauze@finix.eu.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc5: [RESENT PATCH] kernel with Old ide hard disk only support doesn't build.
Message-ID: <20030528054641.GA28230@i486X33>
References: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 04:41:16PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Mainly due to a IDE DMA problem which would happen on boxes with lots of
> RAM, here is -rc5.
> 
> As I always ask, please test.

Hi,

Kernel 2.4.21-rc5 with CONFIG_BLK_DEV_HD_ONLY=y still doen't build (it
doesn't build since 2.4.21-rc3).

I resend this patch which shoud fix the problem.

*** drivers/ide/Makefile.orig   Wed May 28 07:33:33 2003
--- drivers/ide/Makefile        Wed May 28 07:34:03 2003
***************
*** 19,24 ****
--- 19,26 ----
  obj-m         :=
  ide-obj-y     :=
  
+ subdir-$(CONFIG_BLK_DEV_HD_ONLY) += legacy
+ 
  subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid pci
  
  # First come modules that register themselves with the core


FYI, here is the error message:

make -C ide
make[2]: Entering directory `/usr/src/linux-2.4.21-rc5/drivers/ide'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.21-rc5/drivers/ide'
rm -f idedriver.o
ld -m elf_i386  -r -o idedriver.o legacy/idedriver-legacy.o
ld: cannot open legacy/idedriver-legacy.o: No such file or directory
make[3]: *** [idedriver.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-rc5/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-rc5/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc5/drivers'
make: *** [_dir_drivers] Error 2

Best regards.
--
Jerome Chantelauze

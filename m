Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTEZHMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 03:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTEZHMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 03:12:24 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:50180 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S264309AbTEZHMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 03:12:22 -0400
Date: Mon, 26 May 2003 09:28:08 +0200
From: Jerome Chantelauze <jerome.chantelauze@finix.eu.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3: doesn't build with CONFIG_BLK_DEV_HD_ONLY=y
Message-ID: <20030526072808.GA7851@i486X33>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 07:19:38PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes the third release candidate of 2.4.21.
> 

kernel 2.4.21-rc3 doesn't build with CONFIG_BLK_DEV_HD_ONLY=y and
CONFIG_BLK_DEV_IDE not set (a patch is included):

make -C ide
make[2]: Entering directory `/usr/src/linux-2.4.21-rc3/drivers/ide'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.21-rc3/drivers/ide'
rm -f idedriver.o
ld -m elf_i386  -r -o idedriver.o legacy/idedriver-legacy.o
ld: cannot open legacy/idedriver-legacy.o: No such file or directory
make[3]: *** [idedriver.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-rc3/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-rc3/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc3/drivers'
make: *** [_dir_drivers] Error 2

This patch fixes the problem.

*** drivers/ide/Makefile.orig   Sun May 25 17:51:24 2003
--- drivers/ide/Makefile        Sun May 25 17:51:32 2003
***************
*** 19,24 ****
--- 19,26 ----
  obj-m         :=
  ide-obj-y     :=
  
+ subdir-$(CONFIG_BLK_DEV_HD_ONLY) += legacy
+ 
  subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid pci
  
  # First come modules that register themselves with the core


Best regards.
--
Jerome Chantelauze.

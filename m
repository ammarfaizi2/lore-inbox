Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWGTP7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWGTP7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWGTP7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:59:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20656 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030348AbWGTP7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:59:52 -0400
Date: Fri, 21 Jul 2006 02:59:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: CPU hotplug: smoke test
Message-ID: <20060721005903.GC1889@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried running few instances of

while true; do echo 0 > /sys/devices/system/cpu/cpu1/online;   echo 1
> /sys/devices/system/cpu/cpu1/online; done

in paralel. It works okay, but, unfortunately, it provokes strange
failures while trying to build kernel from another console: 

  CHK     include/linux/version.h
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-pxa
make: Makefile:315: fork: Interrupted system call
1.88user 0.78system 11.20 (0m11.206s) elapsed 23.81%CPU
pavel@amd:/data/l/linux-z$

  CHK     include/linux/version.h
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-pxa
make: Makefile:315: fork: Interrupted system call
1.75user 0.72system 6.57 (0m6.578s) elapsed 37.64%CPU
pavel@amd:/data/l/linux-z$

  CC      fs/dnotify.o
make[1]: vfork: Interrupted system call
  CC      kernel/uid16.o
  CC      security/commoncap.o
  CC      ipc/shm.o
  CC      crypto/api.o
  CC      crypto/scatterwalk.o
  LD      security/built-in.o
  CC      kernel/kallsyms.o
  LD      ipc/built-in.o
make: Makefile:876: fork: Interrupted system call
40.89user 8.60system 102.10 (1m42.101s) elapsed 48.48%CPU
pavel@amd:/data/l/linux-z$   CC      crypto/cipher.o
  CC      crypto/digest.o

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

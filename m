Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVHVXIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVHVXIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVHVXIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:08:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64143 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932334AbVHVXIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:08:13 -0400
Date: Sun, 21 Aug 2005 22:36:11 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050822013611.GA28318@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Unfortunately, it seems that current kernels (including vanilla -rc
kernels) don't compile correctly on ppc if I have APM emulation enabled,
but PMU disabled (only CUDA enabled).

Here is what I get from a compilation try:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
debian:~/kernel/linux# make vmlinux
  CHK     include/linux/version.h
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      sound/oss/dmasound/dmasound_awacs.o
sound/oss/dmasound/dmasound_awacs.c:262: warning: 'struct pmu_sleep_notifier' declared inside parameter list
sound/oss/dmasound/dmasound_awacs.c:262: warning: its scope is only this definition or declaration, which is probably not what you want
sound/oss/dmasound/dmasound_awacs.c:263: error: variable 'awacs_sleep_notifier' has initializer but incomplete type
sound/oss/dmasound/dmasound_awacs.c:264: warning: excess elements in struct initializer
sound/oss/dmasound/dmasound_awacs.c:264: warning: (near initialization for 'awacs_sleep_notifier')
sound/oss/dmasound/dmasound_awacs.c:264: error: 'SLEEP_LEVEL_SOUND' undeclared here (not in a function)
sound/oss/dmasound/dmasound_awacs.c:264: warning: excess elements in struct initializer
sound/oss/dmasound/dmasound_awacs.c:264: warning: (near initialization for 'awacs_sleep_notifier')
sound/oss/dmasound/dmasound_awacs.c:1424: error: conflicting types for 'awacs_sleep_notify'
sound/oss/dmasound/dmasound_awacs.c:262: error: previous declaration of 'awacs_sleep_notify' was here
sound/oss/dmasound/dmasound_awacs.c: In function 'awacs_sleep_notify':
sound/oss/dmasound/dmasound_awacs.c:1428: error: 'PBOOK_SLEEP_NOW' undeclared (first use in this function)
sound/oss/dmasound/dmasound_awacs.c:1428: error: (Each undeclared identifier is reported only once
sound/oss/dmasound/dmasound_awacs.c:1428: error: for each function it appears in.)
sound/oss/dmasound/dmasound_awacs.c:1481: error: 'PBOOK_WAKE' undeclared (first use in this function)
sound/oss/dmasound/dmasound_awacs.c:1552: error: 'PBOOK_SLEEP_OK' undeclared (first use in this function)
sound/oss/dmasound/dmasound_awacs.c: In function 'dmasound_awacs_init':
sound/oss/dmasound/dmasound_awacs.c:3057: warning: implicit declaration of function 'pmu_register_sleep_notifier'
make[3]: *** [sound/oss/dmasound/dmasound_awacs.o] Error 1
make[2]: *** [sound/oss/dmasound] Error 2
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

If I enable CONFIG_ADB_PMU, then it compiles fine. :-(


Thanks in advance for any help, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

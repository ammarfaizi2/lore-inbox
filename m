Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUEVBoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUEVBoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUEVBnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:43:16 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:28938 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265200AbUEUXn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:43:29 -0400
Message-ID: <20040521100200.84714.qmail@web13907.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Fri, 21 May 2004 03:02:00 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Broken things in kernel 2.6.6-mm2 and 2.6.6-mm3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.x kernel build system.
make: Entering directory `/tmp/vmware-config2/vmmon-only'
make -C /lib/modules/2.6.6/build/include/.. SUBDIRS=$PWD SRCROOT=$PWD/.
modules
make[1]: Entering directory `/usr/src/linux-2.6.6'
CC [M] /tmp/vmware-config2/vmmon-only/linux/driver.o
/tmp/vmware-config2/vmmon-only/linux/driver.c:131: warning:
initialization from incompatible pointer type
>/tmp/vmware-config2/vmmon-only/linux/driver.c:135: warning:
>initialization from incompatible pointer type
>CC [M] /tmp/vmware-config2/vmmon-only/linux/hostif.o
>/tmp/vmware-config2/vmmon-only/linux/hostif.c: In function
`>HostIF_FreeLockedPages':
>/tmp/vmware-config2/vmmon-only/linux/hostif.c:738: error: structure
>has no member named `count'
>/tmp/vmware-config2/vmmon-only/linux/hostif.c:740: error: structure
>has no member named `count'
>make[2]: *** [/tmp/vmware-config2/vmmon-only/linux/hostif.o] Error 1
>make[1]: *** [/tmp/vmware-config2/vmmon-only] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.6.6'
>make: *** [vmmon.ko] Error 2
>make: Leaving directory `/tmp/vmware-config2/vmmon-only'
>Unable to build the vmmon module.
>

 Yup. I have been bitten by this too. Apparently "count" has been
replaced by "_count" which in addition seems to be "count-1". But there
is now a function "page_count" that does the right thing.

 For VMware I have just removed the definition of the "page_count"
macro from vmmon-only/include/compat_mm.h.

Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de

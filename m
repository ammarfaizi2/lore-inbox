Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUL0DCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUL0DCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 22:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUL0DCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 22:02:05 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:29192 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261743AbUL0DCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 22:02:00 -0500
Date: Mon, 27 Dec 2004 13:31:42 +1030
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.10 make script problems
Message-ID: <20041227030142.GA3321@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Dec 27, 2004 at 01:23:02AM +1030, Mark Williams (MWP) wrote:
>> Hi all,
>> First... im not on lkml, so can you please CC replies back to me, thanks.
>> 
>> This is a werid one...
>> 
>> On running "make menuconfig" for the first time on a freshly extracted
>> "linux-2.6.10.tar.bz2" everything works fine.
>> 
>> >From then on however, running "make" in any form ("make bzImage", "make
>> menuconfig", etc) brings on this:
>> 
>> [root@linux linux-2.6.10]# make bzImage
>> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
>> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
>> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
>> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
>> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
>> ....
>> 
>> which continues until i ctrl-c.
>
>Check your Makefile. It looks like 'make O=...' was executed in the
>wrong directory, thus overwriting the original Makefile.
>
>	Sam

Yes, it seems the root Makefile is being overwritten.

On a cleanly extracted 2.6.10 kernel, when i run "make menuconfig" i get the following:

[root@linux linux-2.6.10]# make menuconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  GEN    /usr/src/linux-2.6.10-ck1/Makefile
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/mconf
  HOSTCC  scripts/lxdialog/checklist.o
  HOSTCC  scripts/lxdialog/inputbox.o
  HOSTCC  scripts/lxdialog/lxdialog.o
  HOSTCC  scripts/lxdialog/menubox.o
  HOSTCC  scripts/lxdialog/msgbox.o
  HOSTCC  scripts/lxdialog/textbox.o
  HOSTCC  scripts/lxdialog/util.o
  HOSTCC  scripts/lxdialog/yesno.o
  HOSTLD  scripts/lxdialog/lxdialog

Note the "GEN /usr/src/linux-2.6.10-ck1/Makefile".
Is this the problem?

Thanks again.

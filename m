Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWHPJnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWHPJnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWHPJnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:43:42 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:39429 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751065AbWHPJnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:43:41 -0400
Message-ID: <44E2E867.2050508@shadowen.org>
Date: Wed, 16 Aug 2006 10:41:59 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Sam Ravnborg <sam@mars.ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-mm1 -- new depancy on curses development
References: <20060813012454.f1d52189.akpm@osdl.org>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/

>  git-lxdialog.patch

This tree seems to change the Makefile dependancies in the kconfig 
subdirectory such that a plain compile of the kernel leads to an attempt 
to build the menuconfig targets.  This in turn adds a new dependancy on 
the curses development libraries.

   08/15/06-05:23:09 building kernel - make -j4 vmlinux
     HOSTCC  scripts/kconfig/lxdialog/checklist.o
   In file included from scripts/kconfig/lxdialog/checklist.c:24:
               scripts/kconfig/lxdialog/dialog.h:31:20: error: curses.h:
               No such file or directory

This seems to come from this rather innocent sounding change in that tree:

commit 9238251dddc15b52656e70b74dffe56193d01215
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Jul 24 21:40:46 2006 +0200

     kconfig/lxdialog: refactor color support

which also seems to change the Makefile about, specifically bringing the 
sub Makefile into the top level one.

[...]
-       $(Q)$(MAKE) $(build)=scripts/kconfig/lxdialog
[...]
+# lxdialog stuff
+check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
[...]

Sam?

-apw

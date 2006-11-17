Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424762AbWKQEHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424762AbWKQEHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 23:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162341AbWKQEHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 23:07:43 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:13154 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1162339AbWKQEHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 23:07:42 -0500
Date: Thu, 16 Nov 2006 20:07:41 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: zippel@linux-m68k.org, jejb <james.bottomley@steeleye.com>
Subject: how to handle indirect kconfig dependencies
Message-Id: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a (randconfig) build of 2.6.19-rc5-mm2 with:

CONFIG_DEBUG_READAHEAD=y

which selects DEBUG_FS, so DEBUG_FS=y, but DEBUG_FS depends on
SYSFS, and SYSFS is not set in the randconfig.

This randconfig causes this build error:

fs/built-in.o: In function `debugfs_init':
inode.c:(.init.text+0xdb2): undefined reference to `kernel_subsys'

so the question is:
(How) can kconfig follow the dependency chain and either
- prevent this odd config combination or
- see that 'select DEBUG_FS' implies 'select SYSFS' and then enable SYSFS
?

I don't believe that the right answer is to add
	depends on SYSFS
to DEBUG_READAHEAD.


.config is at http://oss.oracle.com/~rdunlap/configs/config-readahead-debugfs

Thanks,
---
~Randy [or just kill off select]

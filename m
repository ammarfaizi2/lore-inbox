Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUHSSK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUHSSK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUHSSK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:10:28 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:19180 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266615AbUHSSK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:10:27 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: kallsyms 2.6.8 address ordering
Date: Thu, 19 Aug 2004 18:10:25 +0000
Message-Id: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that LKML of late is unresponsive to a lot bug posts and that email is being blocked for a lot of folks.  It smells like partisan politics based on economic motivations and its not really "open" any more when people stoop to this level of behavior.  That aside:

kallsyms in 2.6.8 is presenting module symbol tables with out of order addresses in 2.6.X.  This makes maintaining a commercial kernel debugger for Linux 2.6 kernels nighmareish.  Also, the need to kmalloc name strings (like kdb does) from kallsyms in kdbsupport.c while IN THE DEBUGGER makes it impossible to debug large portions of the kernel code with kdb, so I have rewritten large sections of kallsyms.c to handle all these broken, brain-dead cases in mdb and I am not relying much on kdb hooks anymore.  Why on earth does Linux need to have shifting tables of test strings for module names requiring all this complexity in the symbol tables and kallsyms.

I don't expect a response so I'll keep coding around the broken Linux 2.6 code but I wanted to post a record of this so perhaps someone will think about over-engineering systems which should be left alone.

Jeff
  

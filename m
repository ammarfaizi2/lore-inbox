Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280768AbRKGNVL>; Wed, 7 Nov 2001 08:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKGNVA>; Wed, 7 Nov 2001 08:21:00 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:52145 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S280768AbRKGNUw>; Wed, 7 Nov 2001 08:20:52 -0500
Message-ID: <3BE93513.8BFD1565@cisco.com>
Date: Wed, 07 Nov 2001 18:50:19 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: axb@cse.nd.edu
Subject: ps2esdi.c broken ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when PS2 ESDI support is enabled (in kernel without module
support) , ps2esdi.c breaks during compilation.

looks like it's missing module.h

ps2esdi.c:153: `THIS_MODULE' undeclared here (not in a function)
ps2esdi.c:153: initializer element for `ps2esdi_fops.owner' is not
constant
ps2esdi.c:157: initializer element for `ps2esdi_fops' is not constant

this fix works ....

--- /home/manik/linux/orig/linux/drivers/block/ps2esdi.c        Fri Oct
26 02:28:34 2001
+++ ./ps2esdi.c Wed Nov  7 18:35:07 2001
@@ -27,6 +27,7 @@
    + reset after read/write error
  */

+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/major.h>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTJXHzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTJXHzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:55:19 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:41958 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262050AbTJXHzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:55:10 -0400
Message-ID: <3F98DB31.4050700@t-online.de>
Date: Fri, 24 Oct 2003 09:56:33 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: Vojtech Pavlik <vojtech@suse.cz>, torvalds@osdl.org
Subject: [PATCH] input / keyboard / Scancode Set 3 support broken
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Ee0U0rZvoeuDMNVZw8bgHBf3V7xEhzgT0oOBsg5x6E75IXIbjcKN8A@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

If somebody uses keyboard scancode set 3 it is necessary to explicitly
program the keyboard to send make/break codes for all keys and to set
autorepeat for all keys. I reported this bug and the suggested fix to
Vojtech Pavlik almost a month ago and he published the enclosed patch.

This patch never made it to the main kernel tree, but it is really critical
for some people. One example is the LK461/46W series of keyboards from Digital 
Equipment Corporations. These are VMS keyboards that are also usable
on a normal PC. 

These keyboards support Scancode Set 2, but for some keys this support is
screwed up -- some function keys (e.g. F18/F20) report the same 
scancode sequence combined with both alt and shift keys.

Scancode Set 3 works perfectly if all keys are programmed to give make/break codes. 

A lot of keyboards manufactured by Cherry only make/break for some (not all!)
modifyer keys in scancode set 3 without this fix.

I believe that this patch is nothing but a very obvious bug fix, please
include it in the linux kernel.

cu,
 Knut Petersen

Below find the patch from Vojtech as published on 29-sep-2003:

===================================================================

ChangeSet@1.1385, 2003-09-29 12:59:49+02:00, vojtech@suse.cz
  input: Explicitly set All-Repeat mode in Set3 on AT keyboards.


 atkbd.c |    3 +++
 1 files changed, 3 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c Mon Sep 29 19:36:59 2003
+++ b/drivers/input/keyboard/atkbd.c Mon Sep 29 19:36:59 2003
@@ -111,6 +111,7 @@
 #define ATKBD_CMD_SETREP 0x10f3
 #define ATKBD_CMD_ENABLE 0x00f4
 #define ATKBD_CMD_RESET_DIS 0x00f5
+#define ATKBD_CMD_SETALL_MBR    0x00fa
 #define ATKBD_CMD_RESET_BAT 0x02ff
 #define ATKBD_CMD_RESEND 0x00fe
 #define ATKBD_CMD_EX_ENABLE 0x10ea
@@ -519,6 +520,8 @@
   if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
   return 2;
  }
+
+ atkbd_command(atkbd, param, ATKBD_CMD_SETALL_MBR);
 
  return 3;
 }



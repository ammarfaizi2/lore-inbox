Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTJQVUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTJQVUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:20:10 -0400
Received: from mx3.evanzo-server.de ([81.209.142.20]:18396 "EHLO
	mx3.evanzo-server.de") by vger.kernel.org with ESMTP
	id S263519AbTJQVUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:20:06 -0400
From: Markus Schoder <markus_schoder@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7: Preempt enabled -> kernel panic
Date: Fri, 17 Oct 2003 23:19:59 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310172319.59776.markus_schoder@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.6.0-test7 with preempt I get a kernel panic
when running the tst-eintr1 test program from the nptl 0.60 package.
It does not happen every time but running it repeatedly will lead
to a panic pretty quickly.

With preempt disabled it's rock solid.

Stack trace is not always the same but there always seems to
be infinite recursion. Also sometimes interrupts are disabled
(no SysRq) and sometimes not.

This is on an Athlon XP, kernel compiled with gcc 3.3.1.

Example stack trace:

...
do_page_fault+0x12c/0x454
poke_blanked_console+0x5c/0x70
try_to_wake_up+0xa7/0x160
default_wake_function+0x2a/0x30
__wake_up_common+0x31/0x60
do_page_fault+0x0/0x454
error_code+0x2d/0x38
do_exit+0x1d2/0x350
do_page_fault+0x0/0x454
die+0xe1/0xf0
do_page_fault+0x12c/0x454
sys_exit+0x13/0x20
syscall_call+0x7/0xb

Code: 8b 5d 68 c7 44 24 20 01 00 03 00 8b 50 14 8b 00 81 e2 ff ff
<6>note: ld-linux.so.2[2069] exited with preempt_count 1

--
Markus


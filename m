Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTINDxk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 23:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbTINDxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 23:53:39 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:51084 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262291AbTINDv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 23:51:59 -0400
Message-ID: <1b7401c37a73$87b0e250$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5 vs. modem cards
Date: Sun, 14 Sep 2003 12:51:36 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When inserting a modem card, 2.6.0-test5 continues to have problems which
earlier 2.6.0-test versions had, which can be solved by booting 2.4.19.

In file 8250_cs.c:
Line 61, identifies itself as "serial_cs.c" instead of "8250_cs.c".
Line 119 identifies itself as "serial_cs" instead of "8250_cs".
My partial understanding of Linux PCMCIA operations yields a guess that line
119 is part of the cause for failure during execution, whereas line 61 only
potentially confuses future maintainers.

Later in the same source file, calls to register_serial() and
unregister_serial() compile but fail during execution.  Of course in order
to make it execute in the first place I have to manually modprobe 8250_cs,
because of the reason mentioned above.  /var/log/messages gets reports that
those symbols are unknown.


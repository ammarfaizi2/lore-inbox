Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266182AbUFUKMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUFUKMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 06:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUFUKMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 06:12:41 -0400
Received: from linux3.cpe.fr ([134.214.50.7]:4525 "EHLO linux3.cpe.fr")
	by vger.kernel.org with ESMTP id S266182AbUFUKMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 06:12:37 -0400
Message-ID: <1087812756.40d6b4948f361@webmail.cpe.fr>
Date: Mon, 21 Jun 2004 12:12:36 +0200
From: PAJANI =?iso-8859-15?b?TmF0aGHrbA==?= <nathael.pajani@cpe.fr>
To: linux-kernel@vger.kernel.org
Subject: multiple use of symbol dbg in headers.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 194.175.117.85
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, I just tryed to see what is behind the "dbg" symbol in the 2.4.24 source
tree, and noticed it was used in different places, with different meanings. I
also checked 2.6.6 source tree, and part of the problem is still there.

Problem: 
+ linux 2.4.24
in include/linux/usb.h
--> #define dbg(format, arg...) printk .......
--> #define dbg(format, arg...) do {} .......
and in include/linux/baycom.h
--> struct baycom_debug_data dbg;
and last in include/linux/soundmodem.h
--> struct sm_debug_data dbg;

+ linux 2.6.6
in include/linux/usb.h
--> #define dbg(format, arg...) printk .......
--> #define dbg(format, arg...) do {} .......
and in include/linux/baycom.h
--> struct baycom_debug_data dbg;

But no more occurence in soundmodem.h


This is no problem for me as I do not include all these files, just the usb.h
But this may be problem for others.

Solution may be to use usb_dbg instead of dbg in usb.h, as it has been done in
device.h and pnp.h

Bye.
I hope this will be usefull.

Nathaël PAJANI

nathael.pajani@cpe.fr

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

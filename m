Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263138AbSJBQWj>; Wed, 2 Oct 2002 12:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbSJBQWj>; Wed, 2 Oct 2002 12:22:39 -0400
Received: from 62-190-203-8.pdu.pipex.net ([62.190.203.8]:12292 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263138AbSJBQWi>; Wed, 2 Oct 2002 12:22:38 -0400
Date: Wed, 2 Oct 2002 17:36:32 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210021636.g92GaWEp000312@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bodge up serial support in 2.5.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Standard 8250/16550 UART support is broken in 2.5.40, and I needed it, so following a bit of advice from Russell King, I've prepared this patch.

I thought I'd post it, just incase anybody else out there actually uses serial ports, (seems they don't).  Before you apply it, bear in mind that the last C I did was a hello world program :-), (only half kidding).

This is a bodge up patch only, NOT an official solution.

John.

--- linux-2.5.40-orig/drivers/serial/core.c	2002-10-02 15:07:21.000000000 +0100
+++ linux-2.5.40/drivers/serial/core.c	2002-10-02 15:09:38.000000000 +0100
@@ -1604,8 +1604,6 @@
 	return retval;
 }
 
-#ifdef CONFIG_PROC_FS
-
 static const char *uart_type(struct uart_port *port)
 {
 	const char *str = NULL;
@@ -1708,7 +1706,6 @@
 	*start = page + (off - begin);
 	return (count < begin + len - off) ? count : (begin + len - off);
 }
-#endif
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 /*

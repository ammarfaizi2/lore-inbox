Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbSJNArb>; Sun, 13 Oct 2002 20:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261787AbSJNArb>; Sun, 13 Oct 2002 20:47:31 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:33772 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP
	id <S261786AbSJNAra>; Sun, 13 Oct 2002 20:47:30 -0400
Message-ID: <3DAA1583.10103@aarnet.edu.au>
Date: Mon, 14 Oct 2002 10:23:23 +0930
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-au, en-gb, en, en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/3 Fix serial console flow control, serialP.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.20-pre8/include/linux/serialP.h    Sat Aug  3 10:09:45 2002
+++ linux-2.4.20-pre8-gdt1/include/linux/serialP.h    Fri Oct 11 13:48:33 2002
@@ -138,6 +138,37 @@
  #endif

  /*
+ * Serial console counters.
+ */
+struct serial_console_counters_t {
+        /* If flow control used: count of characters not printed as
+         * UART transmitter buffer didn't empty after waiting.
+         * If flow control not used: count of characters printed
+         * regardless that the UART transmitter buffer didn't empty
+         * after waiting.
+         */
+        int timeouts_tx;
+        /* Count of characters not printed as flow control used and
+         * DSR or DCD not asserted.
+         */
+        int timeouts_dsr;
+        int timeouts_dcd;
+        /* Count of characters not printed as flow control used and
+         * CTS not asserted after waiting.
+         */
+        int timeouts_cts;
+        /* Count of messages truncated or not printed as flow control
+         * configured and one of the timeout_* conditions occurred.
+         */
+        int  messages_dropped;
+        /* Count of messages offered for printing. Number of
+         * successfully printed messages is (messages -
+         * messages_dropped).
+         */
+        int messages_total;
+};
+
+/*
   * Structures and definitions for PCI support
   */
  struct pci_dev;


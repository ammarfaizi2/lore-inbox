Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVLISDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVLISDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVLISDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:03:08 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:47438 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S964839AbVLISDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:03:06 -0500
X-IronPort-AV: i="3.99,235,1131343200"; 
   d="scan'208"; a="11811069:sNHT27904012"
Date: Fri, 9 Dec 2005 12:03:05 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: minyard@acm.org
Subject: [PATCH 2.6] ipmi: panic generator ID
Message-ID: <20051209180305.GB29231@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IPMI specifcation says the generator ID is 0x20, but that is for
bits 7-1.  Bit 0 is set to specify it is a software event.  The
correct value is 0x41.  Without this fix, panic events written into
the System Event Log appear to come from an "unknown" generator,
rather than from the kernel.

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Ack'd-by: Corey Minyard <minyard@acm.org>


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.6/drivers/char/ipmi/ipmi_msghandler.c	Tue Dec  6 12:53:19 2005
+++ linux-2.6/drivers/char/ipmi/ipmi_msghandler.c	Fri Dec  9 10:27:42 2005
@@ -2986,7 +2986,7 @@ static void send_panic_events(char *str)
 	msg.cmd = 2; /* Platform event command. */
 	msg.data = data;
 	msg.data_len = 8;
-	data[0] = 0x21; /* Kernel generator ID, IPMI table 5-4 */
+	data[0] = 0x41; /* Kernel generator ID, IPMI table 5-4 */
 	data[1] = 0x03; /* This is for IPMI 1.0. */
 	data[2] = 0x20; /* OS Critical Stop, IPMI table 36-3 */
 	data[4] = 0x6f; /* Sensor specific, IPMI table 36-1 */

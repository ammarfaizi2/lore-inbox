Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVBLDEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVBLDEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVBLDEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:04:50 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1776 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262377AbVBLDEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:04:47 -0500
Message-ID: <420D724D.7080302@acm.org>
Date: Fri, 11 Feb 2005 21:04:45 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix IPMI LAN bridging
Content-Type: multipart/mixed;
 boundary="------------020002030508010107000001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020002030508010107000001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020002030508010107000001
Content-Type: text/plain;
 name="ipmi-lan-addr-len.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-lan-addr-len.diff"

The size of LAN bridged messages was not being returned properly from
the function that calculated address sizes.  This fixes the problem.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc3/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.11-rc3.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.11-rc3/drivers/char/ipmi/ipmi_msghandler.c
@@ -480,6 +480,9 @@
 		return sizeof(struct ipmi_ipmb_addr);
 	}
 
+	if (addr_type == IPMI_LAN_ADDR_TYPE)
+		return sizeof(struct ipmi_lan_addr);
+
 	return 0;
 }
 

--------------020002030508010107000001--

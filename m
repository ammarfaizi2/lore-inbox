Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUIXOau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUIXOau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUIXOau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:30:50 -0400
Received: from webapps.arcom.com ([194.200.159.168]:60423 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268769AbUIXOar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:30:47 -0400
Message-ID: <41542F96.2000700@arcom.com>
Date: Fri, 24 Sep 2004 15:30:46 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: rmk+serial@arm.linux.org.uk
Subject: Serial: Request resources if not autoconfiguring new ports
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2004 14:34:58.0906 (UTC) FILETIME=[AB0693A0:01C4A243]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This makes serial core request resources when adding new ports if the 
port isn't to be autoconfigured (UPF_BOOT_AUTOCONF is not set).  This 
also means the UPF_IOREMAP flag now works.

--- linux-2.6-armbe.orig/drivers/serial/serial_core.c	2004-09-23 
15:04:08.000000000 +0100
+++ linux-2.6-armbe/drivers/serial/serial_core.c	2004-09-24 
15:27:01.000000000 +0100
@@ -2007,7 +2007,8 @@
  	if (port->flags & UPF_BOOT_AUTOCONF) {
  		port->type = PORT_UNKNOWN;
  		port->ops->config_port(port, flags);
-	}
+	} else
+		port->ops->request_port(port);

  	if (port->type != PORT_UNKNOWN) {
  		unsigned long flags;

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

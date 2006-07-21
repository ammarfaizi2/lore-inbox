Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWGUNVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGUNVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWGUNVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:21:52 -0400
Received: from smtp.net4india.com ([202.71.129.67]:16568 "EHLO
	smtp.net4india.com") by vger.kernel.org with ESMTP id S1750726AbWGUNVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:21:51 -0400
Message-ID: <44C0D5B0.4000008@designergraphix.com>
Date: Fri, 21 Jul 2006 18:55:04 +0530
From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Reply-To: kaiwan@designergraphix.com
Organization: Designer Graphix
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tim Waugh <tim@cyberelk.demon.co.uk>, Philip Blundell <philb@gnu.org>
Subject: parport: small addition to Documentation/parport-lowlevel.txt 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small note inserted, regarding usage of the parport_unregister_driver 
interface.

Only a single file Documentation/parport-lowlevel.txt is affected 
(pulled from 2.6.18-rc2 :
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=8f2302415eff90b0df7aa655f132f9567ff9ccd7;hb=82d6897fefca6206bca7153805b4c5359ce97fc4;f=Documentation/parport-lowlevel.txt
)

Came across this "issue" while writing a parport-based driver.
Does this make sense?

- Kaiwan.

---
--- parport-lowlevel.vanilla    2006-07-21 18:25:24.000000000 +0530
+++ parport-lowlevel    2006-07-21 18:34:52.000000000 +0530
@@ -258,6 +258,18 @@
        ...
 }

+Note-
+If you are using this interface in the "usual" way, you are probably first
+registering your driver with parport_register_driver and unregistering with
+parport_unregister_driver (as shown in the "lp_driver" example about a page
+up from here). You will have attach and detach function callbacks.
+The point is: when your driver is removed from the kernel, your
+cleanup_module function is invoked, which typically invokes
+parport_unregister_driver. This will cause the detach function to kick in.
+Now, this guy should _not_ be (re)invoking parport_unregister_driver, but
+just parport_unregister_device as necessary.
+
+
 SEE ALSO

 parport_register_driver, parport_enumerate


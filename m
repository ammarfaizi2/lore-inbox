Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVBIR0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVBIR0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVBIR0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:26:05 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38350 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261857AbVBIRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:25:55 -0500
Message-ID: <420A47A1.8020007@acm.org>
Date: Wed, 09 Feb 2005 11:25:53 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix IPMI SMBus driver to select the I2C layer instead of
 depend on it
Content-Type: multipart/mixed;
 boundary="------------000105090209000904020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105090209000904020404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is on top of the IPMI SMBus driver in the current mm kernel.

Thanks,

-Corey

--------------000105090209000904020404
Content-Type: text/plain;
 name="ipmi_smb_config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_smb_config.diff"

Make the IPMI SMBus select I2C, not depend on it, so I2C gets
enabled properly when the IPMI SMBus is enabled.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc3/drivers/char/ipmi/Kconfig
===================================================================
--- linux-2.6.11-rc3.orig/drivers/char/ipmi/Kconfig
+++ linux-2.6.11-rc3/drivers/char/ipmi/Kconfig
@@ -53,7 +53,8 @@
 
 config IPMI_SMB
        tristate 'IPMI SMBus handler'
-       depends on IPMI_HANDLER && I2C
+       depends on IPMI_HANDLER
+       select I2C
        help
          Provides a driver for a SMBus interface to a BMC, meaning that you
 	 have a driver that must be accessed over an I2C bus instead of a

--------------000105090209000904020404--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTH1PMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTH1PMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:12:06 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:62603 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264025AbTH1PME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:12:04 -0400
Date: Thu, 28 Aug 2003 08:11:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1160] New: pnp_allow_dma0 option 
Message-ID: <62220000.1062083496@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1160

           Summary: pnp_allow_dma0 option
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: normal
             Owner: ambx1@neo.rr.com
         Submitter: gt@esi.ac.at


It looks like this option has been moved from isapnp to resource.c, but the
MODULE_PARM line is still there:

--- drivers/pnp/isapnp/core.c.orig      2003-08-28 16:21:08.701450448 +0200
+++ drivers/pnp/isapnp/core.c   2003-08-28 16:22:48.084341952 +0200
@@ -65,7 +65,6 @@
 MODULE_PARM_DESC(isapnp_rdp, "ISA Plug & Play read data port");
 MODULE_PARM(isapnp_reset, "i");
 MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
-MODULE_PARM(isapnp_allow_dma0, "i");
 MODULE_PARM(isapnp_verbose, "i");
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");

Moreover, the new option "allowdma0" in resource.c only allows to set
pnp_allow_dma0 to 1 but not to 0. My original intention was that the
default value is -1 such that:

-1 => the user did not request a specific value and a quirk can set it to 
     1 if some hardware needs this.
0  => the user requested not to use it, and a quirk should not change this



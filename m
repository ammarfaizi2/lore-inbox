Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUJZWDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUJZWDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 18:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUJZWDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 18:03:49 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:61891 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261505AbUJZWDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 18:03:36 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>, ajoshi@shell.unixbox.com,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] radeonfb: If no video memory, exit with error [repost]
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
MIME-Version: 1.0
Date: Tue, 26 Oct 2004 16:03:24 -0600
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_smsfB+Zm1X4evqP"
Message-Id: <200410261603.24434.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_smsfB+Zm1X4evqP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Posted this last week (10/21) but haven't seen any response.
Would you consider this for the next -mm?  Also attached in
case kmail mangles the whitespace.


[PATCH] radeonfb: If no video memory, exit with error

Nothing good will happen if we try to ioremap and use a zero-sized
frame buffer.  I observed this problem on an ia64 sx1000 box, where
the BIOS doesn't run the option ROM.  If we try to continue, radeonfb
just gets hopelessly confused because the card isn't initialized
correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/video/aty/radeon_base.c 1.32 vs edited =====
--- 1.32/drivers/video/aty/radeon_base.c 2004-10-19 03:40:34 -06:00
+++ edited/drivers/video/aty/radeon_base.c 2004-10-21 11:50:51 -06:00
@@ -2186,7 +2186,9 @@
           rinfo->video_ram = 8192 * 1024;
           break;
          default:
-          break;
+   printk (KERN_ERR "radeonfb: no video RAM reported\n");
+   ret = -ENXIO;
+   goto err_unmap_rom;
   }
  }
 

--Boundary-00=_smsfB+Zm1X4evqP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="radeonfb-no-vram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="radeonfb-no-vram.patch"

[PATCH] radeonfb: If no video memory, exit with error

Nothing good will happen if we try to ioremap and use a zero-sized
frame buffer.  I observed this problem on an ia64 sx1000 box, where
the BIOS doesn't run the option ROM.  If we try to continue, radeonfb
just gets hopelessly confused because the card isn't initialized
correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/video/aty/radeon_base.c 1.32 vs edited =====
--- 1.32/drivers/video/aty/radeon_base.c	2004-10-19 03:40:34 -06:00
+++ edited/drivers/video/aty/radeon_base.c	2004-10-21 11:50:51 -06:00
@@ -2186,7 +2186,9 @@
 	       		rinfo->video_ram = 8192 * 1024;
 	       		break;
 	       	default:
-	       		break;
+			printk (KERN_ERR "radeonfb: no video RAM reported\n");
+			ret = -ENXIO;
+			goto err_unmap_rom;
 		}
 	}
 

--Boundary-00=_smsfB+Zm1X4evqP--


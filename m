Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWHVOqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWHVOqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWHVOqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:46:37 -0400
Received: from lug.demon.co.uk ([83.104.159.110]:27995 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S932280AbWHVOqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:46:33 -0400
From: David Johnson <dj@david-web.co.uk>
To: linux-kernel@vger.kernel.org
Subject: sym53c8xx PCI card broken in 2.6.18
Date: Tue, 22 Aug 2006 15:46:11 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Disposition: inline
Cc: sparclinux@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200608221546.11532.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm running a Sun Ultra Enterprise 450 (SPARC64) machine which has an on-board 
SCSI controller and a PCI SCSI controller, both supported by the sym53c8xx 
driver.

With 2.6.17.9 (and earlier) SCSI works perfectly, but with 2.6.18-rc4 and 
2.6.18-rc4-git1 I'm getting errors on boot for all devices attached to the 
PCI card, but all the devices attached to the on-board controller are 
detected and configured OK.

lspci identifies the on-board controller as:
SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 03)
and the PCI controller as:
SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)

Here's the output from initialisation of the devices on the PCI card (repeated 
for every device):
scsi2: sym-2.2.3
scsi 2:0:0:0 ABORT operation started
scsi 2:0:0:0 ABORT operation timed out
scsi 2:0:0:0 DEVICE RESET operation started
scsi 2:0:0:0 DEVICE RESET operation timed out
scsi 2:0:0:0 BUS RESET operation started
scsi 2:0:0:0 BUS RESET operation timed out
scsi 2:0:0:0 HOST RESET operation started
sym2: SCSI bus has been reset
scsi 2:0:0:0 HOST RESET operation timed out
scsi: device offlined - not ready after error recovery

The devices on the PCI controller are a mixture of 'Fujitsu MAG3182L SUN18G' 
and 'Seagate ST318203LSUN18G' drives.

Looking through the changelogs between 2.6.17.9 and 2.6.18-rc4-git1, I can't 
see any changes to sym53c8xx, so I'm guessing this has been caused by some 
generic SCSI subsystem change. Let me know if I can do any more to debug.

Regards,
David.

-- 
David Johnson
www.david-web.co.uk - My Personal Website
www.penguincomputing.co.uk - Need a Web Developer?

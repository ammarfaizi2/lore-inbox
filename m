Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVCNXUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVCNXUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVCNXTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:19:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:14798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262068AbVCNXQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:16:19 -0500
Message-ID: <42361B38.4060704@osdl.org>
Date: Mon, 14 Mar 2005 15:16:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kjhall@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix gcc printk warnings
References: <20050314145522.787a6865.rddunlap@osdl.org> <20050314150825.5f52b1a8.akpm@osdl.org>
In-Reply-To: <20050314150825.5f52b1a8.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090406030205010307080908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406030205010307080908
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> Nope.  Please use %Z for size_t args.

Yeps.  Here it is.

-- 
~Randy

--------------090406030205010307080908
Content-Type: text/x-patch;
 name="tpm_printk_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tpm_printk_v2.patch"



Fix gcc printk arg type warnings:

drivers/char/tpm/tpm.c:145: warning: unsigned int format, different type arg (arg 5)
drivers/char/tpm/tpm.c:153: warning: int format, different type arg (arg 4)
drivers/char/tpm/tpm.c:190: warning: int format, different type arg (arg 4)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/tpm/tpm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./drivers/char/tpm/tpm.c~tpm_printk ./drivers/char/tpm/tpm.c
--- ./drivers/char/tpm/tpm.c~tpm_printk	2005-03-14 08:41:24.000000000 -0800
+++ ./drivers/char/tpm/tpm.c	2005-03-14 15:11:23.000000000 -0800
@@ -143,7 +143,7 @@ static ssize_t tpm_transmit(struct tpm_c
 		return -ENODATA;
 	if (count > bufsiz) {
 		dev_err(&chip->pci_dev->dev,
-			"invalid count value %x %x \n", count, bufsiz);
+			"invalid count value %x %Zx\n", count, bufsiz);
 		return -E2BIG;
 	}
 
@@ -151,7 +151,7 @@ static ssize_t tpm_transmit(struct tpm_c
 
 	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_send: error %d\n", len);
+			"tpm_transmit: tpm_send: error %Zd\n", len);
 		return len;
 	}
 
@@ -188,7 +188,7 @@ out_recv:
 	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
 	if (len < 0)
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_recv: error %d\n", len);
+			"tpm_transmit: tpm_recv: error %Zd\n", len);
 	up(&chip->tpm_mutex);
 	return len;
 }

--------------090406030205010307080908--

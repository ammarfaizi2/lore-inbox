Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTHXMEF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTHXMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:04:05 -0400
Received: from [203.145.184.221] ([203.145.184.221]:35090 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263470AbTHXMEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:04:01 -0400
Subject: Re: [PATCH 2.6.0-test4][NET] 3c509.c: remove device.name field
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030824034735.534b8c68.davem@redhat.com>
References: <1061644409.1141.18.camel@lima.royalchallenge.com> 
	<20030824034735.534b8c68.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 24 Aug 2003 17:55:40 +0530
Message-Id: <1061727940.1288.4.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sun, 2003-08-24 at 16:17, David S. Miller wrote:
> On 23 Aug 2003 18:43:29 +0530
> Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:
> 
> > This patch removes the device name field which is no longer present.
> 
> This doesn't look like the right fix.  You can't just
> delete these lines, you should rather replace them with
> accesses to whatever the MCA device struct name field is.
> 
> 
Pls find the updated patch (hopefully right this time) below:

Thanks
vinay

--- linux-2.6.0-test4/drivers/net/3c509.c	2003-08-23 13:14:30.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/net/3c509.c	2003-08-24 17:51:19.000000000 +0530
@@ -629,8 +629,8 @@
 			   el3_mca_adapter_names[mdev->index], slot + 1);
 
 		/* claim the slot */
-		strncpy(device->name, el3_mca_adapter_names[mdev->index],
-				sizeof(device->name));
+		strncpy(mdev->name, el3_mca_adapter_names[mdev->index],
+				sizeof(mdev->name));
 		mca_device_set_claim(mdev, 1);
 
 		if_port = pos4 & 0x03;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUAVUbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUAVUbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:31:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:15035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266494AbUAVUbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:31:15 -0500
Date: Thu, 22 Jan 2004 12:31:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm1
Message-Id: <20040122123156.2588d0a1.akpm@osdl.org>
In-Reply-To: <20040122151943.GW21151@parcelfarce.linux.theplanet.co.uk>
References: <20040122013501.2251e65e.akpm@osdl.org>
	<20040122110342.A9271@infradead.org>
	<20040122151943.GW21151@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> { raw driver stuff ]
>

I'd be inclined to leave the raw driver as-is, frankly.  It's deprecated,
obsolete and we should be trying to remove it from 2.7.

--- 25/drivers/char/Kconfig~raw-is-obsolete	2004-01-22 12:30:02.000000000 -0800
+++ 25-akpm/drivers/char/Kconfig	2004-01-22 12:31:32.000000000 -0800
@@ -961,12 +961,15 @@ config SCx200_GPIO
 	  If compiled as a module, it will be called scx200_gpio.
 
 config RAW_DRIVER
-	tristate "RAW driver (/dev/raw/rawN)"
+	tristate "RAW driver (/dev/raw/rawN) (OBSOLETE)"
 	help
 	  The raw driver permits block devices to be bound to /dev/raw/rawN. 
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
 	  See the raw(8) manpage for more details.
 
+          The raw driver is deprecated and may be removed from 2.7 kernels.
+          Applications should simply open /dev/hda with the O_DIRECT flag.
+
 config MAX_RAW_DEVS
 	int "Maximum number of RAW devices to support (1-8192)"
 	depends on RAW_DRIVER

_


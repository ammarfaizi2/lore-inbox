Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319033AbSH1WRu>; Wed, 28 Aug 2002 18:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319027AbSH1WRt>; Wed, 28 Aug 2002 18:17:49 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:17679 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319018AbSH1WRq>; Wed, 28 Aug 2002 18:17:46 -0400
Date: Wed, 28 Aug 2002 23:22:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Stevens <dlstevens@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] anycast support for IPv6, linux-2.5.31
Message-ID: <20020828232206.A15161@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Stevens <dlstevens@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <OFA5382C90.D39B906F-ON88256C23.00771A5C@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFA5382C90.D39B906F-ON88256C23.00771A5C@boulder.ibm.com>; from dlstevens@us.ibm.com on Wed, Aug 28, 2002 at 03:44:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 03:44:57PM -0600, David Stevens wrote:
> 
>       Below is a patch relative to the mainline 2.5.31 code for an

I think it would make sense to Cc the netdev list at oss.sgi.com..

(and please inline the patch, makes it much easier to respond..)

diff -urN linux-2.5.31/net/ipv6/anycast.c linux-2.5.31AC/net/ipv6/anycast.c
--- linux-2.5.31/net/ipv6/anycast.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.31AC/net/ipv6/anycast.c	Wed Aug 21 14:24:41 2002
@@ -0,0 +1,508 @@
+/* $Header$ */
+
+/*
+ *	Anycast support for IPv6
+ *	Linux INET6 implementation 
+ *
+ *	Authors:
+ *	David L Stevens (dlsteven@us.ibm.com)
+ *
+ *	$Id$
+ *
+ *	based heavily on net/ipv6/mcast.c
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+/* Changes:
+ *
+ */

Umm, in the kernel tree $Header$ and $Id$ will never be filled out.
Also empty changes comments are pretty useless.

+
+#define __NO_VERSION__

Not needed in 2.4/2.5

+#ifdef CONFIG_IPV6_MLD6_DEBUG
+#include <linux/inet.h>
+#endif

This patch doesn't reference CONFIG_IPV6_MLD6_DEBUG anywhere else..

+
+void ipv6_ac_init_dev(struct inet6_dev *idev)
+{
+}

I can't see this actually beeing used anywhere..

+#ifdef CONFIG_PROC_FS
+int anycast6_get_info(char *buffer, char **start, off_t offset, int length)
+{
+	off_t pos=0, begin=0;
+	struct ifacaddr6 *im;
+	int len=0;
+	struct net_device *dev;
+	
+	read_lock(&dev_base_lock);
+	for (dev = dev_base; dev; dev = dev->next) {
+		struct inet6_dev *idev;
+
+		if ((idev = in6_dev_get(dev)) == NULL)
+			continue;
+
+		read_lock_bh(&idev->lock);
+		for (im = idev->ac_list; im; im = im->aca_next) {
+			int i;


This function would really benefit from use of the seq_file API..


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268109AbUHFJmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268109AbUHFJmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 05:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268112AbUHFJmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 05:42:24 -0400
Received: from [145.253.187.130] ([145.253.187.130]:28428 "EHLO
	proxy.baslerweb.com") by vger.kernel.org with ESMTP id S268109AbUHFJmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 05:42:15 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Device class reference counting
Date: Fri, 6 Aug 2004 11:43:47 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407301803.00269.thomas.koeller@baslerweb.com> <20040805224656.GA22545@kroah.com> <200408061137.47099.thomas.koeller@baslerweb.com>
In-Reply-To: <200408061137.47099.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061143.47858.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,

seems the patch got messsed up somehow, so I am
resending it:

--- linux-mips/drivers/base/class.c     2004-07-14 16:21:33.000000000 +0200
+++ linux-mips-work/drivers/base/class.c        2004-08-06 11:06:10.983688216 +0200
@@ -349,14 +349,19 @@

 int class_device_add(struct class_device *class_dev)
 {
-       struct class * parent;
+       struct class * parent = NULL;
        struct class_interface * class_intf;
        int error;

        class_dev = class_device_get(class_dev);
-       if (!class_dev || !strlen(class_dev->class_id))
+       if (!class_dev)
                return -EINVAL;

+       if (!strlen(class_dev->class_id)) {
+               error = -EINVAL;
+               goto register_done;
+       }
+
        parent = class_get(class_dev->class);

        pr_debug("CLASS: registering class device: ID = '%s'\n",

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUAPXcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbUAPXcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:32:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:21128 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265768AbUAPXca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:32:30 -0500
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: kobj_to_dev ?
Date: Fri, 16 Jan 2004 17:32:29 -0600
To: Greg KH <gregkh@us.ibm.com>
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, could this be added to device.h:

--- 1.112/include/linux/device.h        Wed Jan  7 23:58:16 2004
+++ edited/include/linux/device.h       Fri Jan 16 17:35:04 2004
@@ -279,6 +279,8 @@
         void    (*release)(struct device * dev);
  };

+#define kobj_to_dev(k) container_of((k), struct device, kobj)
+
  static inline struct device *
  list_to_dev(struct list_head *node)
  {

I'm using it as the following (inspired by find_bus), and it seems like 
it would make sense to put in device.h.

struct vio_dev *vio_find_device(const char *name)
{
	struct kobject *kobj;

	kobj = kset_find_obj(&vio_bus_type.devices, name);
	if (!kobj)
		return NULL;

	return to_vio_dev(kobj_to_dev(kobj));
}

As a side node, since those #defines don't to type-checking, would it 
make sense to name them with both types? E.g. "kobj_to_dev" instead of 
just "to_dev"?

-- 
Hollis Blanchard
IBM Linux Technology Center


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTKLAki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbTKLAki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:40:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:53940 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263855AbTKLAkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:40:36 -0500
Date: Tue, 11 Nov 2003 16:45:19 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Badness in atomic_dec_and_test in 2.6.0-test9-mm2
Message-ID: <20031112004519.GA1771@beaverton.ibm.com>
Mail-Followup-To: Bradley Chapman <kakadu_croc@yahoo.com>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20031111222731.72833.qmail@web40912.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111222731.72833.qmail@web40912.mail.yahoo.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman [kakadu_croc@yahoo.com] wrote:
> (I sent a previous version of this e-mail to the linux-scsi and usb-storage
> mailinglists mentioned in MAINTAINERS, but received no response)
> 
> When I unplug my USB Mass Storage device after unmounting it, I get the following
> badness message:

Greg posted a response the other day to a query from Alan Stern. Here is
the link 
http://marc.theaimsgroup.com/?l=linux-kernel&m=106835250124362&w=2

This should be the same problem that you are hitting.

A patch was checked into Linus's tree on 2003-11-07 by Greg that made a
couple line change to class.c.

Here is the patch in case you need to stay on mm2.

-andmike
--
Michael Anderson
andmike@us.ibm.com

--- 1.41/drivers/base/class.c	Fri Aug 29 14:18:26 2003
+++ 1.42/drivers/base/class.c	Fri Nov  7 06:48:28 2003
@@ -255,6 +255,7 @@
 
 void class_device_initialize(struct class_device *class_dev)
 {
+	kobj_set_kset_s(class_dev, class_obj_subsys);
 	kobject_init(&class_dev->kobj);
 	INIT_LIST_HEAD(&class_dev->node);
 }
@@ -277,7 +278,6 @@
 
 	/* first, register with generic layer. */
 	kobject_set_name(&class_dev->kobj, class_dev->class_id);
-	kobj_set_kset_s(class_dev, class_obj_subsys);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
 

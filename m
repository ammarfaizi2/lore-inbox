Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUHJMIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUHJMIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUHJMIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:08:14 -0400
Received: from [145.253.187.130] ([145.253.187.130]:2060 "EHLO
	proxy.baslerweb.com") by vger.kernel.org with ESMTP id S261184AbUHJMIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:08:09 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Device class reference counting
Date: Tue, 10 Aug 2004 14:09:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407301803.00269.thomas.koeller@baslerweb.com> <200408061143.47858.thomas.koeller@baslerweb.com> <20040806194729.GA25345@kroah.com>
In-Reply-To: <20040806194729.GA25345@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408101409.43696.thomas.koeller@baslerweb.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 21:47, Greg KH wrote:
> On Fri, Aug 06, 2004 at 11:43:47AM +0200, Thomas Koeller wrote:
> > Sorry,
> >
> > seems the patch got messsed up somehow, so I am
> > resending it:
>
> This patch looks good.  But it has the tabs stripped out of it, and no
> Signed-off-by: line.  Care to resend it with that fixed up?
>
> thanks,
>
> greg k-h

Hi greg,

here's the patch again, re-created against 2.6.8-rc3.
This time I even managed to read
Documentation/SubmittingPatches ;-)

The tabs are all there, if they are stripped again somewhere
along the way, it is beyond my control. If this should happen,
could you fix that on your side?

thanks,
Thomas



Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

--- linux-2.6.8-rc3-orig/drivers/base/class.c	2004-08-07 12:19:01.000000000 +0200
+++ linux-2.6.8-rc3/drivers/base/class.c	2004-08-07 12:27:32.112631077 +0200
@@ -349,15 +349,20 @@ void class_device_initialize(struct clas
 
 int class_device_add(struct class_device *class_dev)
 {
-	struct class * parent;
+	struct class * parent = NULL;
 	struct class_interface * class_intf;
 	int error;
 
 	class_dev = class_device_get(class_dev);
-	if (!class_dev || !strlen(class_dev->class_id))
+	if (!class_dev)
 		return -EINVAL;
 
-	parent = class_get(class_dev->class);
+	if (!strlen(class_dev->class_id)) {
+		error = -EINVAL;
+		goto register_done;
+	}
+
+ 	parent = class_get(class_dev->class);
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

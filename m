Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUI1HFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUI1HFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 03:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUI1HFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 03:05:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:19124 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267612AbUI1HFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 03:05:34 -0400
Message-ID: <41590CB9.8060405@suse.de>
Date: Tue, 28 Sep 2004 09:03:21 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: hotplug <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NULL arg for get_device() / put_device()
References: <415805DD.4040708@suse.de> <20040928012801.GA11125@kroah.com>
In-Reply-To: <20040928012801.GA11125@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------050905060005070201040605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905060005070201040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Greg KH wrote:
> On Mon, Sep 27, 2004 at 02:21:49PM +0200, Hannes Reinecke wrote:
> 
>>Hi all,
>>
>>is there a specific reason that get_device accepts NULL as argument,
>>whereas put_device() does not?
> 
> 
> Um, I guess I never thought about it :)
> 
> I don't see why it wouldn't take it, feel free to send a patch.
> 
Here it is. Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------050905060005070201040605
Content-Type: text/x-patch;
 name="null-argument-for-put_device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="null-argument-for-put_device.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/28 08:59:54+02:00 hare@lammermuir.suse.de 
#   Since get_device() accepts a NULL argument, put_device() should do so, too.
#   
#   Signed-off-by: Hannes Reinecke <hare@suse.de>
# 
# drivers/base/core.c
#   2004/09/28 08:59:49+02:00 hare@lammermuir.suse.de +2 -1
#   put_device() should accept a NULL argument.
# 
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-09-28 09:01:20 +02:00
+++ b/drivers/base/core.c	2004-09-28 09:01:20 +02:00
@@ -293,7 +293,8 @@
  */
 void put_device(struct device * dev)
 {
-	kobject_put(&dev->kobj);
+	if (dev)
+		kobject_put(&dev->kobj);
 }
 
 

--------------050905060005070201040605--
